# Highly extensible Vim-based text editor
{
  pkgs,
  pkgs-unstable,
  dotfiles,
  ...
}: {
  # Dependencies for ./config/nvim
  home = {
    packages = with pkgs; [
      ripgrep
      fd
      unzip
      gnumake
      gcc

      # lsp
      nixd
      lua-language-server
    ];
    file = {
      # neovim's config
      ".config/nvim" = {
        source = "${dotfiles}/xdg/nvim";
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
