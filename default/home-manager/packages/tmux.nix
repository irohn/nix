# home-manager/tmux.nix

{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g prefix2 C-Space
      bind C-Space send-prefix
      set -g escape-time 0
      set -g history-limit 100000
      set -g history-file ~/.config/tmux/log/tmuxhistory
      set -g monitor-activity off
      set -g visual-activity off
      setw -g monitor-bell off
      set -g bell-action none
      set -g set-clipboard on
      setw -g wrap-search off
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
      set -g base-index 1
      set -g renumber-windows on
      set -g message-style "fg=#1F1F28,bg=#E6C384"
      set -g mouse on
    '';
  };
}
