# GPU-accelerated cross-platform terminal emulator and multiplexer
{
  pkgs,
  dotfiles,
  stow,
  ...
}:

{
  home = {
    packages = with pkgs; [
      wezterm
    ];
    file =
      if !stow then
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
