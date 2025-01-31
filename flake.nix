{
  description = "Personal Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "git+ssh://git@github.com/irohn/xdg";
      flake = false;
    };
    greenix = {
      url = "git+ssh://git@github.com/greeneyetechnology/greenix";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      darwin,
      agenix,
      ...
    }@inputs:
    let
      username = "ori";
      email = {
        personal = "orisneh@gmail.com";
        work = "orisne@greeneye.ag";
      };
      stow = true; # set this to true to manually use gnu-stow instead
      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      darwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
    in
    {
      homeConfigurations = forAllSystems (
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            agenix.homeManagerModules.default
            ./users/${username}
          ];
          extraSpecialArgs = inputs // {
            inherit username email stow;
          };
        }
      );
      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (
        system:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./hosts/darwin/macbook
          ];
          specialArgs = inputs // {
            inherit username;
          };
        }
      );
      nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (
        system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos/desktop
          ];
          specialArgs = inputs // {
            inherit username;
          };
        }
      );
    };
}
