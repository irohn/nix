# Terminal multiplexer for managing multiple terminal sessions
{
  pkgs,
  lib,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      baseIndex = 1;
      prefix = "C-Space";
      clock24 = true;
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.better-mouse-mode
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = /* bash */ ''
            set-option -g status-position top

            # Override windows status icons
            set -g @catppuccin_icon_window_last "󰖰"
            set -g @catppuccin_icon_window_current "󰖯"
            set -g @catppuccin_icon_window_zoom "󰁌"
            set -g @catppuccin_icon_window_mark "󰃀"
            set -g @catppuccin_icon_window_silent "󰂛"
            set -g @catppuccin_icon_window_activity "󱅫"
            set -g @catppuccin_icon_window_bell "󰂞"

            set -g @catppuccin_window_left_separator "█"
            set -g @catppuccin_window_right_separator "█"
            set -g @catppuccin_window_middle_separator "█ "
            set -g @catppuccin_window_number_position "left"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules_right "user session"
            set -g @catppuccin_status_left_separator  " "
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_fill "icon"
            set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_status_background "default"

            set -g @catppuccin_status_justify "left"

            # Colors
            set -g @catppuccin_window_default_color "#7f848e" # text color
            set -g @catppuccin_window_default_background "#5c6370"

            set -g @catppuccin_window_current_color "#9ece6a" # text color
            set -g @catppuccin_window_current_background "#24283b"

            set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,#[fg=#a48cf2]  ,}#{?pane_synchronized,#[fg=#a48cf2]  ,}"
          '';
        }
      ];
      extraConfig = /* bash */ ''
        set -as terminal-features ",xterm-256color:RGB"
        set -g renumber-windows on
        set -g mouse on

        set-window-option -g mode-keys vi

        unbind R
        bind R source-file ~/.config/tmux/tmux.conf

				bind C-h set-option -g status

        # Pane navigation
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Join last used pane into current window
        bind-key @ join-pane -h -s '!'
        # bind-key ! break-pane -t '!' # <- this is set by default

        # synchronize all panes in a window (multi-exec)
        # Prefix + Shift-M
        unbind M
        bind M set-window-option synchronize-panes

				set-option -g allow-passthrough on
      '';
    };

    zsh = {
      shellAliases = {
        tmux = "tmux -u";
        tm = "tmux -u attach";
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
      '';
    };
  };
}
