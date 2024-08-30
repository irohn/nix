{
  description = "Nix and Home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let

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
          ] ++ extraModules;
        };

      # TODO: Add helper function for nixos and darwin-nix configurations

    in {
      # TODO: Add nixos / darwin conigurations, maybe combine overlapping arguments?

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#<config-name>'
      homeConfigurations = {
        ori-macbook = mkHomeConfiguration {
          system = "aarch64-darwin";
          username = "ori";
          email = "orisne@greeneye.ag";
          extraModules = [
            ./home-manager/modules/core
            ./home-manager/modules/git
            ./home-manager/modules/zsh
            ./home-manager/modules/zoxide
            ./home-manager/modules/fonts
            ./home-manager/modules/starship
            ./home-manager/modules/tmux
            ./home-manager/modules/neovim
            ./home-manager/modules/kubernetes
            ./home-manager/modules/wezterm
            ./home-manager/modules/greeneye
          ]; # modules specific to this machine
        };
        ori-desktop = mkHomeConfiguration {
          system = "x86_64-linux";
          username = "ori";
          email = "orisneh@gmail.com";
          extraModules = [
            ./home-manager/modules/core
            ./home-manager/modules/git
            ./home-manager/modules/zsh
            ./home-manager/modules/zoxide
            ./home-manager/modules/fonts
            ./home-manager/modules/starship
            ./home-manager/modules/tmux
            ./home-manager/modules/neovim
            ./home-manager/modules/kubernetes
            ./home-manager/modules/wezterm
          ];
        };
      };
    };
}
