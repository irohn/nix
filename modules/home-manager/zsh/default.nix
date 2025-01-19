{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initExtra = ''
      export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
    '';
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
  };
}
