# home-manager/zsh.nix

{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "kubectl"
      ]; # Add or remove plugins as needed
      theme = "robbyrussell"; # You can change this to your preferred theme
    };
    sessionVariables = {
      TEST = "test";
    };
    initExtra = ''
      stty -ixon

      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      setopt completealiases
    '';

    shellAliases = {
      v = "nvim";
      ls = "eza";
      ll = "eza -lAh";
      la = "eza -laa";
      lt = "eza --almost-all --tree --color=auto --icons=auto --git-ignore --smart-group --mounts --level=5";
      cat = "bat";
      ai = "ollama run deepseek-coder-v2:latest";
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
}
