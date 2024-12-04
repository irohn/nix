# GPU-accelerated cross-platform terminal emulator and multiplexer
{ dotfiles, ... }:

{
  home.file = {
    ".config/wezterm" = {
      source = "${dotfiles}/xdg/wezterm";
      recursive = true;
    };
  };
}
