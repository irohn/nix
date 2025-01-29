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
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
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
      agenix,
      dotfiles,
      greenix,
      ghostty,
      ...
    }@inputs:
    let
      homeDependencies = [
        ./users/ori/home.nix
        { _module.args = { inherit dotfiles; }; }
        { _module.args = { inherit greenix; }; }
        agenix.homeManagerModules.default
      ];
      homeArgs = {
        username = "ori";
        email = {
          personal = "orisneh@gmail.com";
          work = "orisne@greeneye.ag";
        };
        use_stow = true;
      };
    in
    {
      homeConfigurations = {
        macbook = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          modules = homeDependencies;
          extraSpecialArgs = homeArgs;
        };
        desktop = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = homeDependencies;
          extraSpecialArgs = homeArgs;
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
