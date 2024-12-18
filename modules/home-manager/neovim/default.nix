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

      # external tools like lsp, formatters etc...
      nixd
      nixfmt-rfc-style

      lua-language-server
      stylua

      bash-language-server
      shellcheck
      shfmt

      pyright
      black
      isort
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
