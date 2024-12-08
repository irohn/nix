{ pkgs, config, ... }:

{
  imports = [
    ./system.nix
    ./users.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/common/tailscale
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # make default mac zsh align with nixpkgs
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system.stateVersion = 4;
}