{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    nodejs
    unzip
    gcc
  ];

  programs.zsh.sessionVariables = lib.mkMerge [
    (lib.mkIf (config.programs.zsh.enable) {
      EDITOR = "nvim";
    })
  ];

  home.file = {
    # neovim's config
    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };
  };
}
