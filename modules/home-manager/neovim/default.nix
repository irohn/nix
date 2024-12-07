# Highly extensible Vim-based text editor
{ pkgs, dotfiles, ... }:

{
  # Dependencies for ./config/nvim
  home = {
    packages = with pkgs; [
      unzip
      ripgrep
      fd
      gnumake
      gcc
      cargo
    ];

    file = {
      ".config/nvim" = {
        source = "${dotfiles}/xdg/nvim";
        recursive = true;
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
