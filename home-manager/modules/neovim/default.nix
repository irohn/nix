# Highly extensible Vim-based text editor
{
  pkgs,
  pkgs-unstable,
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
        source = ./config/nvim;
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
			viAlias = true;
    };

  };
}
