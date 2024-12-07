{ config, pkgs, ... }:

{
  # enable zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ori = {
    isNormalUser = true;
    description = "Ori";
    # change default shell
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
