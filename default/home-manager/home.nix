# home-manager configuration file
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 

let
  default_username = "ori";  # Replace with your preferred default username
  default_homeDir = "/home/${default_username}";

  username = builtins.getEnv "USER";
  homeDir = builtins.getEnv "HOME";
in {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./packages/neovim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = if username != "" then username else default_username;
    homeDirectory = if homeDir != "" then homeDir else default_homeDir;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    curl
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.
}
