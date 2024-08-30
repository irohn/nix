# home-manager configuration file
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    yq
    gawk
    bat
    eza
  ];
}
