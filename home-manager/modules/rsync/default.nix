# fast incremental file transfer
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rsync
    fswatch
  ];
}
