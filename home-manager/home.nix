# home-manager configuration file
{ config, pkgs, username, email, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    packages = with pkgs; [
      # Core packages to install in all homes
      curl
      wget
      vim
      jq
      yq
      gawk # ensure gnu-awk for uniformity across systems
      unixtools.watch
    ];

    stateVersion = "24.05"; # Please read the comment before changing.
  };

  nix = {
    package = pkgs.nix;
    # Enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
