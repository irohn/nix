{ ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - h [
        "alacritty" : skhd -k "ctrl - b" && skhd -k "shift - h"
      ]
    '';
  };
}
