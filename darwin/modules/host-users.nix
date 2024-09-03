{
  hostname,
  username,
  ...
}: {
  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [ username ];
}
