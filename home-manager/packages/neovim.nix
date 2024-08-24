{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    nodejs
    unzip
    gcc
  ];

  home.file = {
    # neovim's config
    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
