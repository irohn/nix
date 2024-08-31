# A smarter cd command that learns your habits
{ config, pkgs, lib, ... }:

{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = {
      cd = "__zoxide_z";
    };
  };
}
