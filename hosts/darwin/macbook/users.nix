{ ... }:

{
  networking = {
    hostName = "macbook";
    computerName = "macbook";
  };

  system.defaults.smb.NetBIOSName = "macbook";

  users.users.ori = {
    home = "/Users/ori";
    description = "Ori";
  };

  nix.settings.trusted-users = [ "ori" ];
}
