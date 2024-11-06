{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./modules/system.nix
    ./modules/host-users.nix
    ./modules/apps.nix
    ./modules/window-manager.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # make default mac zsh align with nixpkgs
  programs.zsh.enable = true;

  age.secrets = {
    test = {
      file = ../secrets/test;
    };
    master_password = {
      file = ../secrets/master_password;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system.stateVersion = 4;
}
