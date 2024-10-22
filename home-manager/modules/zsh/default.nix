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
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell"; # You can change this to your preferred theme
      };

      sessionVariables = {
        TEST = "test";
      };
      initExtra = /* bash */ ''
      stty -ixon

      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      setopt completealiases

			# Natural text editing
			# Move to the beginning of the line. `Cmd + Left Arrow`:
			bindkey "^[[1;9D" beginning-of-line
			# Move to the end of the line. `Cmd + Right Arrow`:
			bindkey "^[[1;9C" end-of-line
			# Move to the beginning of the previous word. `Option + Left Arrow`:
			bindkey "^[[1;3D" backward-word
			# Move to the beginning of the next word. `Option + Right Arrow`:
			bindkey "^[[1;3C" forward-word
			# Delete the word behind the cursor. `Option + Delete`:
			bindkey "^[[3;10~" backward-kill-word
			# Delete the word after the cursor. `Option + fn + Delete`:
			bindkey "^[[3;3~" kill-word
      '';

      shellAliases = {
        ai = /* bash */ "ollama run deepseek-coder-v2:latest \"$''{@}\"";
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
      ];
    };
  };
}
