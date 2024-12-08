# GPU-accelerated cross-platform terminal emulator and multiplexer
{ pkgs, dotfiles, ... }:

{
  home = {
    packages = with pkgs; [
      wezterm
    ];
    file = {
      ".config/wezterm" = {
        source = "${dotfiles}/config/wezterm";
        recursive = true;
      };
    };
  };
}
