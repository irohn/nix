# home-manager configuration file
{ pkgs, username, ... }:

{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    stateVersion = "24.11";
  };

  imports = [
    ../../modules/common/secrets/agenix-home.nix
    ../../modules/home-manager/1password
    ../../modules/home-manager/alacritty
    ../../modules/home-manager/brave
    ../../modules/home-manager/direnv
    ../../modules/home-manager/eza
    ../../modules/home-manager/fonts
    ../../modules/home-manager/git
    ../../modules/home-manager/greeneye
    ../../modules/home-manager/kubernetes
    ../../modules/home-manager/neovim
    ../../modules/home-manager/rsync
    ../../modules/home-manager/slack
    ../../modules/home-manager/starship
    ../../modules/home-manager/tmux
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/zsh
    # ../../modules/home-manager/discord
    ../../modules/home-manager/hashicorp
  ];

  # let home-manager manage itself.
  programs.home-manager.enable = true;
}
