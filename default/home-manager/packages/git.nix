{ config, pkgs, lib, defaults, ... }:

{
  programs.git = {
    enable = true;
    userName = defaults.username;
    userEmail = defaults.email;
  };
}
