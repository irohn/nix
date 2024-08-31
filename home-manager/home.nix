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
    ];

    stateVersion = "24.05"; # Please read the comment before changing.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
