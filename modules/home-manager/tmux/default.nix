# Terminal multiplexer for managing multiple terminal sessions
{
  pkgs,
  lib,
  dotfiles,
  ...
}:

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

    shellAliases = {
      tssh = "~/.config/tmux/tssh.sh";
    };
  };

  programs.zsh.initExtra =
    lib.mkAfter # bash
      ''
        # execute tmux on shell startup
        if [ -z "$TMUX" ]; then
          tmux -u new-session -A -s default
        fi
      '';
}
