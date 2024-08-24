{ pkgs, ... }:

{
  home.packages = with pkgs; [
    curl
    wget
    jq
    yq
    gawk
    bat
    eza
    zoxide
  ];
}
