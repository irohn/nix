{
  dotfiles,
  use_stow,
  ...
}:

{
  home.file =
    if !use_stow then
      {
        ".config/ghostty" = {
          source = "${dotfiles}/config/ghostty";
          recursive = true;
        };
      }
    else
      { };
}
