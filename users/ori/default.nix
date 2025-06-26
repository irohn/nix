# home-manager configuration file
{ pkgs, username, ... }:

{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    shellAliases = {
      hms = "home-manager switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')";
      drs = "darwin-rebuild switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')";
      nrs = "sudo nixos-rebuild switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')";
    };

    stateVersion = "24.11";
  };

  imports = [
    ../../modules/home-manager/secrets
    ../../modules/home-manager/1password
    ../../modules/home-manager/ghostty
    ../../modules/home-manager/brave
    ../../modules/home-manager/cursor
    ../../modules/home-manager/direnv
    ../../modules/home-manager/eza
    ../../modules/home-manager/fonts
    ../../modules/home-manager/fzf
    ../../modules/home-manager/git
    ../../modules/home-manager/greeneye
    ../../modules/home-manager/kubernetes
    ../../modules/home-manager/neovim
    ../../modules/home-manager/obsidian
    ../../modules/home-manager/password-store
    ../../modules/home-manager/python
    ../../modules/home-manager/vscode
    ../../modules/home-manager/rsync
    ../../modules/home-manager/slack
    ../../modules/home-manager/starship
    ../../modules/home-manager/ssh
    ../../modules/home-manager/stow
    ../../modules/home-manager/tmux
    ../../modules/home-manager/zoxide
    ../../modules/home-manager/zsh
    ../../modules/home-manager/hashicorp
  ];

  # let home-manager manage itself.
  programs.home-manager.enable = true;
}
