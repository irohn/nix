{ config, pkgs, lib, ... }:

{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = config.home.email;
  };
}
