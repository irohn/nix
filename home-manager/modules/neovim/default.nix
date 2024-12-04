# Highly extensible Vim-based text editor
{
  pkgs,
  pkgs-unstable,
  nvim-config,
  ...
}: {
  # Dependencies for ./config/nvim
  home = {
    packages = with pkgs; [
      ripgrep
      fd
      nodejs
      go
      cargo
      unzip
      gnumake
      gcc
    ];
    file = {
      # neovim's config
      ".config/nvim" = {
        source = nvim-config;
        recursive = true;
      };
    };
  };

  programs = {
    neovim = {
      package = pkgs-unstable.neovim-unwrapped;
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

  };
}
