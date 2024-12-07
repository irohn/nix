{
  description = "Nix and Home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:irohn/config";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    darwin,
    nixos-wsl,
    agenix,
    dotfiles,
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

      mkHomeConfiguration = { system, username, email, extraModules ? [] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home-manager/home.nix {_module.args = {inherit dotfiles;};} ] ++ extraModules;
          extraSpecialArgs = { inherit inputs outputs username email; };
        };

      mkDarwinConfiguration = { system, hostname, username, email, extraModules ? [] }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin/configuration.nix
          ] ++ extraModules;
          specialArgs = { inherit inputs outputs hostname username email; };
        };

    in {
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
        desktop = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            ./home-manager/users/ori/home.nix
            {_module.args = {inherit dotfiles;};}
            inputs.agenix.homeManagerModules.default
          ];
          extraSpecialArgs = {
            username = "ori";
            email = "orisneh@gmail.com";
          };
        };
      };

      darwinConfigurations = {
        macbook = mkDarwinConfiguration {
          hostname = "macbook";
          system = "aarch64-darwin";
          username = settings.defaults.username;
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
          ];
        };
      };
    };
}
