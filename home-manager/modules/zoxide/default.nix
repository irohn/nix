{ config, pkgs, lib, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh.shellAliases = lib.mkMerge [
    (lib.mkIf (config.programs.zsh.enable) {
      gs = "git status";
      cd = "__zoxide_z";
    })
  ];
}
