# Configuration for user fonts
{ pkgs, ... }:

{
  # required to autoload fonts from packages installed via Home Manager
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
