{ config, pkgs, username, email, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/host-users.nix
    ./modules/apps.nix
  ];
}
