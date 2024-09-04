# Terminal multiplexer for managing multiple terminal sessions
{
  lib,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      extraConfig = /* tmux */ ''
      # Address vim mode switching delay (http://superuser.com/a/252717/65504)
      set -s escape-time 0

      # Increase scrollback buffer size from 2000 to 50000 lines
      # set history file path
      set -g history-limit 50000
      set -g history-file ~/.config/tmux/log/tmuxhistory

      # Increase tmux messages display duration from 750ms to 4s
      set -g display-time 4000

      # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
      set -g status-interval 5

      # Upgrade $TERM
      set -g default-terminal "screen-256color"

      # Emacs key bindings in tmux command prompt (prefix + :) are better than
      # vi keys, even for vim users
      set -g status-keys emacs

      # Focus events enabled for terminals that support them
      set -g focus-events on

      # Super useful when using "grouped sessions" and multi-monitor setup
      setw -g aggressive-resize on

      # Start from index 1 for easier tab switching
      set -g base-index 1
      set -g renumber-windows on

      # Enable mouse
      set -g mouse on

      # Easier and faster switching between next/prev window
      bind C-p previous-window
      bind C-n next-window

      # Prefix
      unbind C-b
      set-option -g prefix C-space
      bind C-Space send-prefix
      bind space last-window

      # Sync system clipboard with tmux's
      set -g set-clipboard external

      # Prevent tmux from displaying "Activity in window n"
      set -g monitor-activity off
      set -g visual-activity off

      # remove bell alerts
      setw -g monitor-bell off
      set -g bell-action none

      # Source tmux config
      bind r source-file ~/.config/tmux/tmux.conf

      # Pane navigation
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D

      # Pane borders
      set -g pane-border-style 'fg=#30363f'
      set -g pane-active-border-style 'fg=#4fa6ed'
      set -g pane-border-lines "single"

      # Status bar colors and configuration
      set -g status-position top
      set -g status on
      set -g status-interval 1
      set -g status-style "fg=#a0a8b7,bg=#1f2329"
      set -g status-left-length 40
      set -g status-left "#[fg=#4fa6ed,bg=#181b20] #{session_name} #[fg=#a0a8b7,bg=#1f2329] "
      set -g window-status-format "#[fg=#a0a8b7,bg=#1f2329] #I #W "
      set -g window-status-current-format "#[fg=#e2b86b,bg=#30363f,bold] #I #W "
      set -g window-status-separator "#[fg=#535965,bg=#1f2329]|"
      set -g status-justify centre
      set -g status-right-length 40
      set -g status-right "#[fg=#4fa6ed,bg=#181b20] %H:%M:%S"
      set -g message-style "fg=#1f2329,bg=#e2b86b"
      '';
    };

    zsh = {
      shellAliases = {
        tmux = "tmux -u";
        tm = "tmux -u attach";
      };

      initExtra = lib.mkAfter /* bash */ ''
      sessionizer() {
        local selected=$(fd -H -t d '^.git$' ~ --exclude .local -x echo {//} | fzf --preview "eza -A --color=always {}")
        [ -z "$selected" ] && echo "Error: empty selection..." && return 1
        local session_name=$(basename "$selected" | tr . _)
        if ! tmux has-session -t="$session_name" 2>/dev/null; then
          tmux new-session -ds "$session_name" -c "$selected"
        fi
        [ -z "$TMUX" ] && tmux attach -t "$session_name" || tmux switch-client -t "$session_name"
      }
      bindkey -s '^S' 'sessionizer\n'
      '';
    };
  };
}
