# configuration.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    # This file is required and you should probably
    # copy it from /etc/nixos/hardware-configuration.nix
    # unless you know what you are doing.
    ./hardware-configuration.nix
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    curl
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05"; # Did you read the comment?
}
