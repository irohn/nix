# A cat clone with syntax highlighting and Git integration
{ pkgs, lib, config, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      pager = "never";
      style = "plain";
      theme = "OneHalfDark";
    };
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.bat.enable {
    cat = "bat";
  };
}
