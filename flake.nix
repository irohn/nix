{
  description = "Nix and Home-manager configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # age-encrypted secrets for Nix https://github.com/ryantm/agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, agenix, ... }:
    let

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
          extraSpecialArgs = { inherit username email; };
        };

      # Helper function to create a darwin configuration
      mkDarwinConfiguration = { system, hostname, username, email, extraModules ? [] }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [ ./darwin/configuration.nix ] ++ extraModules;
          specialArgs = { inherit hostname username email; };
        };

      mkNixosConfiguration = { system, hostname, username, email, extraModules ? [] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            agenix.nixosModules.default
            ({ pkgs, ... }: {
              nixpkgs.hostPlatform = system;
              system = {
                # Set Git commit hash for nixos-version
                configurationRevision = self.rev or self.dirtyRev or null;
                stateVersion = "24.05";
              };
            })
            {
              # expose inputs to submodules
              _module.args = {
                inherit hostname username email;
              };
            }
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
            }
          ] ++ extraModules;
        };

    in {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#<config-name>'
      homeConfigurations = {
        ori-pc = mkHomeConfiguration {
          system = settings.defaults.system;
          username = settings.defaults.username;
          email = settings.defaults.email;
          extraModules = [ ];
        };
        ori-macbook = mkHomeConfiguration {
          system = "aarch64-darwin";
          username = settings.defaults.username;
          email = "orisne@greeneye.ag";
          extraModules = [ ./home-manager/modules/greeneye ];
        };
      };

      # Darwin configuration entrypoint
      # Available through `darwin-rebuild switch --flake .#<config-name>`
      darwinConfigurations = {
        ori-macbook = mkDarwinConfiguration {
          system = "aarch64-darwin";
          username = settings.defaults.username;
          hostname = "macbook";
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
      };

      # NixOS configuration entrypoint
      # Available through `nixos-rebuild switch --flake .#<config-name>`
      # nixosConfigurations = {
      #   ori-wsl = mkNixosConfiguration {
      #     system = settings.defaults.system;
      #     username = settings.defaults.username;
      #     hostname = "nixos-wsl";
      #     email = settings.defaults.email;
      #     extraModules = [ ];
      #   };
      # };

    };
}
