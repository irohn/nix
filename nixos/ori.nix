
{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/networking.nix
  ];

  # Set your time zone
  time.timeZone = "Asia/Jerusalem";  # Adjust this to your timezone

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

}
