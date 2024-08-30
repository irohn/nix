{ pkgs, config, lib, ... }:

{
  # Dependencies for ./config/nvim
  home.packages = with pkgs; [
    ripgrep
    fd
    nodejs
    unzip
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    # neovim's config
    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
