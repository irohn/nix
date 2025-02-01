# Highly extensible Vim-based text editor
{
  pkgs,
  dotfiles,
  stow,
  ...
}:

{
  # Dependencies for ./config/nvim
  home = {
    packages = with pkgs; [
      unzip
      ripgrep
      fd
      gnumake
      gcc
      nodejs

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

      yaml-language-server
      yamlfix
    ];

    file =
      if !stow then
        {
          ".config/nvim" = {
            source = "${dotfiles}/config/nvim";
            recursive = true;
          };
        }
      else
        { };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

}
