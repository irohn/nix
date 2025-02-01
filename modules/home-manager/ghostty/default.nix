{
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = !(pkgs.stdenv.isDarwin);
    enableZshIntegration = true;
    settings = {
      keybind = [
        "super+h=text:\\x02p"
        "super+l=text:\\x02n"
        "super+one=text:\\x021"
        "super+two=text:\\x022"
        "super+three=text:\\x023"
        "super+four=text:\\x024"
        "super+five=text:\\x025"
        "super+six=text:\\x026"
        "super+seven=text:\\x027"
        "super+eight=text:\\x028"
        "super+nine=text:\\x029"
        "super+zero=text:\\x020"
        "alt+one=text:\\x021"
        "alt+two=text:\\x022"
        "alt+three=text:\\x023"
        "alt+four=text:\\x024"
        "alt+five=text:\\x025"
        "alt+six=text:\\x026"
        "alt+seven=text:\\x027"
        "alt+eight=text:\\x028"
        "alt+nine=text:\\x029"
        "alt+zero=text:\\x020"
      ];
      window-decoration = false;
      window-padding-balance = true;
      theme = "Apple System Colors";
    };
  };

  # this is here until ghostty package works on darwin
  home.file = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
    ".config/ghostty/config".text = ''
      keybind=super+h=text:\x02p
      keybind=super+l=text:\x02n
      keybind=super+one=text:\x021
      keybind=super+two=text:\x022
      keybind=super+three=text:\x023
      keybind=super+four=text:\x024
      keybind=super+five=text:\x025
      keybind=super+six=text:\x026
      keybind=super+seven=text:\x027
      keybind=super+eight=text:\x028
      keybind=super+nine=text:\x029
      keybind=super+zero=text:\x020
      keybind=alt+one=text:\x021
      keybind=alt+two=text:\x022
      keybind=alt+three=text:\x023
      keybind=alt+four=text:\x024
      keybind=alt+five=text:\x025
      keybind=alt+six=text:\x026
      keybind=alt+seven=text:\x027
      keybind=alt+eight=text:\x028
      keybind=alt+nine=text:\x029
      keybind=alt+zero=text:\x020
      window-decoration=false
      window-padding-balance=true
      theme=Apple System Colors
    '';
  };
}
