{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc
    stremio
  ];
}
