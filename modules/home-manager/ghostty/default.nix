{
  pkgs,
  dotfiles,
  stow,
  ...
}:

{
  home.packages = with pkgs; [
    ghostty
  ];
  home.file =
    if !stow then
      {
        ".config/ghostty" = {
          source = "${dotfiles}/config/ghostty";
          recursive = true;
        };
      }
    else
      { };
}
