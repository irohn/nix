# GPU-accelerated cross-platform terminal emulator and multiplexer
{
  pkgs,
  dotfiles,
  use_stow,
  ...
}:

{
  home = {
    packages = with pkgs; [
      wezterm
    ];
    file =
      if !use_stow then
        {
          ".config/wezterm" = {
            source = "${dotfiles}/config/wezterm";
            recursive = true;
          };
        }
      else
        { };
  };
}
