{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mos
  ];
}
