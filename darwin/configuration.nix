{
  pkgs,
  ...
}: {
  imports = [
    ./modules/system.nix
    ./modules/host-users.nix
    ./modules/apps.nix
  ];

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  age.secrets = {
    test.file = ../secrets/test.age;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system.stateVersion = 4;
}
