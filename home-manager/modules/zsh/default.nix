# Z shell configuration with enhanced features over bash
{
  pkgs,
  ...
}: {
  programs = {

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
			autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
			historySubstringSearch.enable = true;

      sessionVariables = {
        TEST = "test";
      };

				#   initExtra = /* bash */ ''
				# stty -ixon
				# setopt completealiases
				#   '';

      shellAliases = {
        ai = /* bash */ "ollama run deepseek-coder-v2:latest \"$''{@}\"";
      };

    };
  };
}
