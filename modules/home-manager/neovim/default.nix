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

      # lsp
      nixd
      lua-language-server
    ];

    file = {
      ".config/nvim" = {
        source = "${dotfiles}/config/nvim";
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
