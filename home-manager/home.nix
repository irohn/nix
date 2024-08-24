# home-manager configuration file
{
  inputs,
  lib,
  config,
  pkgs,
  defaults,
  ...
}: 

let
  # Set your defaults by setting the environment
  # variables before running the flake
  default_username = defaults.username;
  default_email = defaults.email;

  username = let u = builtins.getEnv "USER"; in if u != "" then u else default_username;
  homeDir = let h = builtins.getEnv "HOME"; in if h != "" then h else "/home/${username}";
  email = let e = builtins.getEnv "EMAIL"; in if e != "" then e else default_email;
in {
  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/utils.nix
    ./modules/fonts.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/kubernetes.nix
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
