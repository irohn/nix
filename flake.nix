{
  description = "nix and home-manager config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
    } @ inputs: let
      inherit (self) outputs;

      # Define defaults here
      defaults = {
        username = "ori";
        email = "orisneh@gmail.com";
      };

      # Helper function to create home-manager configuration
      mkHomeConfiguration = system: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs outputs defaults;
        };
        modules = [
          ./home-manager/home.nix
        ];
      };

      # Helper function to create NixOS configuration
      mkNixosConfiguration = {
        system,
        hostname,
        extraModules ? [],
        }: nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs defaults;
          };
          modules = [
            ./nixos/configuration.nix
            {networking.hostName = hostname;}
          ] ++ extraModules;
        };

    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        linux-x86 = mkNixosConfiguration {
          system = "x86_64-linux";
          hostname = "computer";
        };
        rpi = mkNixosConfiguration {
          system = "aarch64-linux";
          hostname = "raspberry-pi"
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#default'
      homeConfigurations = {
        linux-x86 = mkHomeConfiguration "x86_64-linux";
        darwin-aarch64 = mkHomeConfiguration "aarch64-darwin";
      };
    };
}
