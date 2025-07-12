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
      cargo
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
