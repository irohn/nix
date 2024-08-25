{ pkgs, config, lib, ... }:

{

  programs.zsh.sessionVariables = lib.mkMerge [
    (lib.mkIf (config.programs.zsh.enable) {
      FLUXCD_REPO_NAME = "rt-versions";
    })
  ];

  programs.zsh.shellAliases = lib.mkMerge [
    (lib.mkIf (config.programs.zsh.enable) {
      gcli = "echo greeneye";
    })
  ];

  programs.zsh.initExtra = lib.mkAfter ''
    FLUXCD_PATH="$(fd -t d --max-results 1 ^$FLUXCD_REPO_NAME$ $HOME)"
    tssh() {
      echo "$FLUXCD_PATH"
    }
  '';

}
