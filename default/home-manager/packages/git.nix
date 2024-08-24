{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = config.home.email;
  };
}
