{ config, pkgs, username, email, ... }:

{
  imports = [
    ./modules/git
    ./modules/zsh
    ./modules/eza
    ./modules/bat
    ./modules/zoxide
    ./modules/fonts
    ./modules/starship
    ./modules/tmux
    ./modules/neovim
    ./modules/kubernetes
    ./modules/wezterm
  ];
}
