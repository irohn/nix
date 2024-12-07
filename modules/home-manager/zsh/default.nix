# Z shell configuration with enhanced features over bash
{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      zsh-history-substring-search
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = config.home.shellAliases;
    initExtra = ''
    HISTORY_SUBSTRING_SEARCH_PREFIXED=true;
    HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
    source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[OA' history-substring-search-up
    bindkey '^[[A' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
    bindkey '^[[B' history-substring-search-down
    '';
  };
}
