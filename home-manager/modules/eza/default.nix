# A modern replacement for 'ls' with color support and Git integration
{ pkgs, lib, config, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
    extraOptions = [
      "--color-scale"
      "--group-directories-first"
    ];
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.eza.enable {
    ls = "eza";
    ll = "eza -lAh";
    la = "eza -laa";
    lt = "eza --almost-all --tree --color=auto --icons=auto --git-ignore --smart-group --mounts --level=5";
  };
}
