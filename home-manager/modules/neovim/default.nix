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
        source = pkgs.fetchFromGitHub {
          owner = "irohn";
          repo = "nvim";
          rev = "master";
          sha256 = "sha256-iOS2HJ32Y4zqArahmfOYmwsUxBd+goeXm00D11fdawQ=";
        };
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
