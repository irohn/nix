# fast incremental file transfer
{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rsync
    fswatch
  ];
}
