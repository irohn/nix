{
  description = "NixOS + standalone home-manager config flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    templates = {
      ori = {
        description = ''
          Main flake - contains only the configs.
        '';
        path = ./main;
      };
    };
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
