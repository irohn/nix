{ pkgs, ... }:

{
  imports = [
    ./system.nix
    ./users.nix
    ../../../modules/darwin/homebrew.nix
    ../../../modules/darwin/skhd.nix
    ../../../modules/darwin/mouse-fix.nix
    ../../../modules/shared/tailscale
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # make default mac zsh align with nixpkgs
  programs.zsh.enable = true;

  nix.package = pkgs.nix;

  ids.uids.nixbld = 350;

  system.stateVersion = 5;
}
