# home-manager configuration file
{ pkgs, config, username, ... }:

{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    packages = with pkgs; [
      # user stable packages
    ];

    stateVersion = "24.11";
  };

  imports = [
    ../../../modules/common/secrets/agenix-home.nix
    ../../../modules/home-manager/1password
    ../../../modules/home-manager/alacritty
    ../../../modules/home-manager/brave
    ../../../modules/home-manager/direnv
    ../../../modules/home-manager/eza
    ../../../modules/home-manager/fonts
    ../../../modules/home-manager/git
    ../../../modules/home-manager/neovim
    ../../../modules/home-manager/starship
    ../../../modules/home-manager/tmux
    ../../../modules/home-manager/zoxide
    ../../../modules/home-manager/zsh
  ];

  # let home-manager manage itself.
  programs.home-manager.enable = true;
}
