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
      url = "github:irohn/xdg";
      flake = false;
    };
  };

  outputs = {
    dotfiles,
    ...
    } @inputs: let

      homeDependencies = [
        {_module.args = {inherit dotfiles;};}
        inputs.agenix.homeManagerModules.default
      ];

    in {
      homeConfigurations = {
        macbook = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";
          modules = [ ./home-manager/users/ori/home.nix ] ++ homeDependencies;
          extraSpecialArgs = {
            username = "ori";
            email = "orisne@greeneye.ag";
          };
        };
        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home-manager/users/ori/home.nix ] ++ homeDependencies;
          extraSpecialArgs = {
            username = "ori";
            email = "orisneh@gmail.com";
          };
        };
      };

      darwinConfigurations = {
        macbook = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/macbook/configuration.nix
          ];
        };
      };

      nixosConfigurations = {
        desktop = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
          ];
        };
      };
    };
}
