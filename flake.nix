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

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    dotfiles = {
      url = "git+ssh://git@irohn/irohn/xdg";
      flake = false;
    };

    greenix = {
      url = "git+ssh://git@greeneye/greeneyetechnology/greenix";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      agenix,
      dotfiles,
      greenix,
      ghostty,
      ...
    }@inputs:
    let
      homeDependencies = [
        { _module.args = { inherit dotfiles; }; }
        { _module.args = { inherit greenix; }; }
        agenix.homeManagerModules.default
      ];

      use_stow = true;
    in
    {
      homeConfigurations = {
        macbook = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          modules = [ ./users/ori/home.nix ] ++ homeDependencies;
          extraSpecialArgs = {
            username = "ori";
            email = "orisne@greeneye.ag";
            inherit use_stow;
          };
        };
        desktop = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./users/ori/home.nix ] ++ homeDependencies;
          extraSpecialArgs = {
            username = "ori";
            email = "orisneh@gmail.com";
            inherit use_stow;
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
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
            { environment.systemPackages = [ ghostty.packages."x86_64-linux".default ]; }
          ];
        };
      };
    };
}
