{
  description = "Nix and Home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # age-encrypted secrets for Nix https://github.com/ryantm/agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    darwin,
    nixos-wsl,
    agenix,
    ...
    } @inputs: let
      inherit (self) outputs;
      settings = {
        defaults = {
          username = "ori";
          email = "orisneh@gmail.com";
          system = "x86_64-linux";
        };
      };

      # Helper function to create a home-manager configuration
      mkHomeConfiguration = { system, username, email, extraModules ? [] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home-manager/home.nix ] ++ extraModules;
          extraSpecialArgs = { inherit inputs outputs username email; };
        };

      # Helper function to create a darwin configuration
      mkDarwinConfiguration = { system, hostname, username, email, extraModules ? [] }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin/configuration.nix
            agenix.darwinModules.default
            { environment.systemPackages = [ agenix.packages.${system}.default ]; }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./home-manager/home.nix;
                extraSpecialArgs = { inherit inputs outputs username email; };
              };
              # Add home-manager to PATH
              environment.systemPackages = [ home-manager.packages.${system}.home-manager ];
            }
          ] ++ extraModules;
          specialArgs = { inherit inputs outputs hostname username email; };
        };

      mkNixosConfiguration = { system, hostname, username, email, extraModules ? [] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages.${system}.default ]; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = import ./home-manager/home.nix;
                extraSpecialArgs = { inherit inputs outputs username email; };
              };
              environment.systemPackages = [ home-manager.packages.${system}.home-manager ];
            }
          ] ++ extraModules;
          specialArgs = { inherit inputs outputs hostname username email; };
        };

    in {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager switch --flake .#<config-name>'
      homeConfigurations = {
        pinix = mkHomeConfiguration {
          system = "aarch64-linux";
          username = settings.defaults.username;
          email = settings.defaults.email;
          extraModules = [ ];
        };
        macbook = mkHomeConfiguration {
          system = "aarch64-darwin";
          username = settings.defaults.username;
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
        wsl = mkHomeConfiguration {
          system = settings.defaults.system;
          username = "nixos";
          email = settings.defaults.email;
          extraModules = [ ];
        };
      };

      # Darwin configuration entrypoint
      # Available through `darwin-rebuild switch --flake .#<config-name>`
      darwinConfigurations = {
        macbook = mkDarwinConfiguration {
          hostname = "macbook";
          system = "aarch64-darwin";
          username = settings.defaults.username;
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
      };

      # NixOS configuration entrypoint
      # Available through `nixos-rebuild switch --flake .#<config-name>`
      nixosConfigurations = {
        pinix = mkNixosConfiguration {
          hostname = "nixos";
          system = "aarch64-linux";
          username = "ori";
          email = settings.defaults.email;
          extraModules = [ nixos-hardware.nixosModules.raspberry-pi-4 ./nixos/raspberrypi.nix ];
        };
        nixos-wsl = mkNixosConfiguration {
          hostname = "nixos";
          system = settings.defaults.system;
          username = "nixos";
          email = settings.defaults.email;
          extraModules = [ nixos-wsl.nixosModules.wsl ./nixos/wsl.nix ];
        };
      };

    };
}
