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

      # Define common modules for each user
      commonModules = {
        ori = {
          homeManager = [
            ./home-manager/modules/git
            ./home-manager/modules/zsh
            ./home-manager/modules/eza
            ./home-manager/modules/bat
            ./home-manager/modules/zoxide
            ./home-manager/modules/fonts
            ./home-manager/modules/starship
            ./home-manager/modules/tmux
            ./home-manager/modules/neovim
            ./home-manager/modules/kubernetes
            ./home-manager/modules/wezterm
            ./home-manager/modules/greeneye
          ];
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
          ] ++ (commonModules.${username}.homeManager or []) ++ extraModules;
        };

      # TODO: Add helper function for nixos configurations

      # Helper function to create darwin configuration
      mkDarwinConfiguration = { system, username, email, extraModules ? [] }:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              users.users.${username}.home = "/Users/${username}";
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = { ... }: {
                  imports = [ ./home-manager/home.nix ] 
                    ++ (commonModules.${username}.homeManager or []);
                  home = {
                    inherit username;
                    homeDirectory = "/Users/${username}";
                    stateVersion = "24.05";
                  };
                  _module.args = {
                    inherit username email;
                  };
                };
              };
            }
          ] ++ extraModules;
        };

    in {
      # TODO: Add nixos conigurations, maybe combine overlapping arguments?

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#<config-name>'
      homeConfigurations = {
        ori-macbook = mkHomeConfiguration {
          system = "aarch64-darwin";
          username = "ori";
          email = "orisne@greeneye.ag";
          extraModules = [ ];
        };
        ori-desktop = mkHomeConfiguration {
          system = "x86_64-linux";
          username = "ori";
          email = "orisneh@gmail.com";
          extraModules = [ ];
        };
      };

      # Darwin configuration entrypoint
      # Available through 'darwin-rebuild switch --flake .#<config-name>'
      darwinConfigurations = {
        ori-macbook = mkDarwinConfiguration {
          system = "aarch64-darwin";
          username = "ori";
          email = "orisne@greeneye.ag";
          extraModules = [
            # ./darwin/modules/system
            # ./darwin/modules/apps
            # ... (other Darwin-specific modules)
          ];
        };
      };

    };
}
