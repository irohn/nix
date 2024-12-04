# Z shell configuration with enhanced features over bash
{
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = pkgs.zsh-history-substring-search.pname;
        src = pkgs.zsh-history-substring-search.src;
      }
      {
        name = pkgs.zsh-nix-shell.pname;
        src = pkgs.zsh-nix-shell.src;
      }
    ];
  };
}
