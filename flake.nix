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
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }:
    let

      # Define user level settings
      settings = {
        ori = {
          defaults = {
            username = "ori";
            email = "orisneh@gmail.com";
            system = "x86_64-linux";
          };
          homeManager = [ ./home-manager/ori.nix ];
          darwin = [ ./darwin/ori.nix ];
        };
        # Add other users here
        # anotheruser.homeManager = [ ... ];
      };

      # Helper function to create home-manager configuration
      mkHomeConfiguration = { system, username, email, extraModules ? [] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home-manager/home.nix
            {
              home = {
                inherit username;
                homeDirectory = if nixpkgs.legacyPackages.${system}.stdenv.isDarwin
                  then "/Users/${username}"
                  else "/home/${username}";
                stateVersion = "24.05";
              };
              _module.args = {
                inherit username email;
              };
            }
          ] ++ (settings.${username}.homeManager or []) ++ extraModules;
        };

      mkDarwinConfiguration = { system, hostname, username, email, extraModules ? [] }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin/configuration.nix
            ({ pkgs, ... }: {
              nixpkgs.hostPlatform = system;
              system = {
                # Set Git commit hash for darwin-version
                configurationRevision = self.rev or self.dirtyRev or null;
                stateVersion = 4;
              };
            })
            {
              # expose inputs to submodules
              _module.args = {
                inherit hostname username email;
              };
            }
          ]
          ++ (settings.${username}.darwin or []) ++ extraModules;
        };

      # TODO: Add helper function for nixos configurations

    in {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#<config-name>'
      homeConfigurations = {
        ori-pc = mkHomeConfiguration {
          system = settings.ori.defaults.system;
          username = settings.ori.defaults.username;
          email = settings.ori.defaults.email;
          extraModules = [ ];
        };
        ori-macbook = mkHomeConfiguration {
          system = "aarch64-darwin";
          username = settings.ori.defaults.username;
          email = "orisne@greeneye.ag";
          extraModules = [ ./home-manager/modules/greeneye ];
        };
      };

      # Darwin configuration entrypoint
      # Available through `darwin-rebuild switch --flake .#<config-name>`
      darwinConfigurations = {
        ori-macbook = mkDarwinConfiguration {
          system = "aarch64-darwin";
          username = settings.ori.defaults.username;
          hostname = "macbook";
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
      };
    };
}
