{ config, lib, pkgs, hostname, ... }:

  # Define a user account
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user
    initialPassword = "changeme";
  };
