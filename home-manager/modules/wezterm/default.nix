# GPU-accelerated cross-platform terminal emulator and multiplexer
{ ... }:

{
  home.file = {
    # neovim's config
    ".config/wezterm" = {
      source = ./config/wezterm;
      recursive = true;
    };
  };
}
