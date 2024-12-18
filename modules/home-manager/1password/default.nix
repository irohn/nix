{ pkgs, ... }:

{
  home.packages =
    if pkgs.stdenv.isDarwin then
      [ ]
    else
      with pkgs;
      [
        _1password-gui
        _1password-cli
      ];
}
