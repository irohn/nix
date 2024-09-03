{ pkgs, system, ... }:

{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  imports = [
    agenix.darwinModules.default
    ./modules/system.nix
    ./modules/host-users.nix
    ./modules/apps.nix
  ];

  nixpkgs.hostPlatform = system;

  system = {
    # Set Git commit hash for darwin-version
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 4;
  };

  environment.systemPackages = [ agenix.packages.${system}.default ];

  # expose inputs to submodules
  _module.args = { inherit hostname username email; };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
