# A smarter cd command that learns your habits
{ config, pkgs, lib, ... }:

{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = lib.mkIf (config.programs.zoxide.enable && config.programs.zsh.enable) {
      cd = "__zoxide_z";
    };
  };
}
