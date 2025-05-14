# Terminal multiplexer for managing multiple terminal sessions
{
  pkgs,
  lib,
  dotfiles,
  stow,
  ...
}:

{

  home = {
    packages = with pkgs; [
      tmux
    ];

    file =
      if !stow then
        {
          ".config/tmux" = {
            source = "${dotfiles}/config/tmux";
            recursive = true;
          };
        }
      else
        { };

    shellAliases = {
      tssh = "~/.config/tmux/tssh.sh";
    };
  };

  programs.zsh.initContent =
    lib.mkAfter # bash
      ''
        # execute tmux on shell startup
        if [ -z "$TMUX" ]; then
          tmux -u new-session -A -s default
        fi
      '';
}
