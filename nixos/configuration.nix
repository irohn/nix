{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules/host-users.nix
    ./modules/networking.nix
    ./modules/system.nix
  ] ++ lib.optional (builtins.pathExists /etc/nixos/hardware-configuration.nix)
    /etc/nixos/hardware-configuration.nix;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    curl
    git
  ];

  age = {
    identityPaths = [ "/etc/ssh/id_ed25519" ];
    secrets = {
      test = {
        file = ../secrets/test;
      };
      master_password = {
        file = ../secrets/master_password;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05"; # Did you read the comment?
}
