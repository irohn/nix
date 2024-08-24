# home-manager configuration file
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 

let
  # Set your defaults here or by setting the environment
  # variables before running the flake
  default_username = "ori";
  default_email = "orisneh@gmail.com";

  username = let u = builtins.getEnv "USER"; in if u != "" then u else default_username;
  homeDir = let h = builtins.getEnv "HOME"; in if h != "" then h else "/home/${username}";
  email = let e = builtins.getEnv "EMAIL"; in if e != "" then e else default_email;
in {
  imports = [
    (import ./packages/git.nix { inherit username email; })
    ./packages/zsh.nix
    ./packages/utils.nix
    ./packages/fonts.nix
    ./packages/starship.nix
    ./packages/tmux.nix
    ./packages/neovim.nix
    ./packages/kubernetes.nix
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
    username = username;
    homeDirectory = homeDir;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    curl
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.
}
