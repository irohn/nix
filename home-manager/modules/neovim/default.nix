# Highly extensible Vim-based text editor
{ pkgs, config, lib, ... }:

let
  requiredDependencies = with pkgs; [
    ripgrep
    fd
    nodejs
    unzip
    gcc
  ];
in

  {
  # Dependencies for ./config/nvim
  home = {
    packages = requiredDependencies;
    file = {
      # neovim's config
      ".config/nvim" = {
        source = ./config/nvim;
        recursive = true;
      };
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    zsh.shellAliases = lib.mkIf (config.programs.neovim.enable && config.programs.zsh.enable) {
      v = "nvim";
    };
  };
}
