# Terminal multiplexer for managing multiple terminal sessions
{ pkgs, lib, dotfiles, ... }:

{

  home = {
    packages = with pkgs; [
      tmux
    ];

    file = {
      ".config/tmux" = {
        source = "${dotfiles}/config/tmux";
        recursive = true;
      };
    };
  };

  programs.zsh = {
    shellAliases = {
      tmux = "tmux -u";
      ss = "sessionizer";
    };

    initExtra = lib.mkAfter /* bash */ ''
        sessionizer() {
          local selected=$(fd -H -t d '^.git$' ~ --exclude .local --exclude .cargo --max-depth 4 -x echo {//} | fzf --preview "eza -A --color=always {}")
          [ -z "$selected" ] && echo "Error: empty selection..." && return 1
          local session_name=$(basename "$selected" | tr . _)
          if ! tmux has-session -t="$session_name" 2>/dev/null; then
            tmux new-session -ds "$session_name" -c "$selected"
          fi
          [ -z "$TMUX" ] && tmux attach -t "$session_name" || tmux switch-client -t "$session_name"
        }

        bindkey -s '^S' 'sessionizer\n'

        # Check we are not already in a tmux session
        if [ -z "$TMUX" ]; then
          tmux -u new-session -A -s default
        fi
    '';
  };
}
