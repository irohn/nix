{
  dotfiles,
  ...
}:

{
  home.file = {
    ".config/ghostty" = {
      source = "${dotfiles}/config/ghostty";
      recursive = true;
    };
  };
}
