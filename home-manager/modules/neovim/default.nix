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
      cargo
      unzip
      gcc
      sshpass # for ssh.nvim password authentication

      # Language servers (LSP)
      lua-language-server
      pyright
      yaml-language-server
      helm-ls
      nil # nix (nil_ls)
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
