# Terminal multiplexer for managing multiple terminal sessions

{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
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
      set -g pane-border-style 'fg=#DCD7BA'
      set -g pane-active-border-style 'fg=#6A9589'
      set -g pane-border-lines "double"

      # Status bar colors and configuration
      set -g status-position top
      set -g status on
      set -g status-interval 1
      set -g status-style "fg=#DCD7BA,bg=#1F1F28"
      set -g status-left-length 40
      set -g status-left "#[fg=#7E9CD8,bg=#16161D] #{session_name} #[fg=#C8C093,bg=#1F1F28] "
      set -g window-status-format "#[fg=#C8C093,bg=#1F1F28] #I #W "
      set -g window-status-current-format "#[fg=#E6C384,bg=#2A2A37,bold] #I #W "
      set -g window-status-separator "#[fg=#54546D,bg=#1F1F28]|"
      set -g status-justify centre
      set -g status-right-length 40
      set -g status-right "#[fg=#7E9CD8,bg=#16161D] %H:%M:%S"
      set -g message-style "fg=#1F1F28,bg=#E6C384"
    '';
  };

  programs.zsh.shellAliases = lib.mkIf config.programs.tmux.enable {
    tmux = "tmux -u";
    tm = "tmux -u attach";
  };

  programs.zsh.initExtra = lib.mkIf config.programs.tmux.enable ''
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
}