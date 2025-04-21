{ ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      cmd - h [
        "alacritty" : skhd -k "ctrl - b" && skhd -k "p"
        "ghostty" : skhd -k "ctrl - b" && skhd -k "p"
        "terminal" : skhd -k "ctrl - b" && skhd -k "p"
        "wezterm" : skhd -k "ctrl - b" && skhd -k "p"
        "iterm2" : skhd -k "ctrl - b" && skhd -k "p"
        "neovide" : skhd -k "ctrl - b" && skhd -k "p"
      ]
      cmd - [1-9] [
        "neovide" : skhd -k "ctrl - b" && skhd -k "$(/usr/bin/printf '%s' "''${SKHD_KEY}")"
      ]
    '';
  };
}
