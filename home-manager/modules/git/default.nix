{ config, pkgs, lib, username, email, ... }:

{
  home.packages = with pkgs; [
    diff-so-fancy
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "diff-so-fancy";
        };
      };
    };
  };

  programs.zsh.shellAliases = lib.mkMerge [
    (lib.mkIf (config.programs.zsh.enable) {
      gs = "git status";
    })
  ];

  programs.zsh.initExtra = lib.mkAfter ''
    bindkey -s "^L" 'tmux popup -E -h 90% -w 90% "lazygit"^M'
  '';

  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    aliases = {
      unstage = "reset HEAD --";
      sync = "!f() { \
        local branch=$(git rev-parse --abbrev-ref HEAD); \
        git fetch origin $branch:$branch; \
        git merge-base --is-ancestor $branch origin/$branch || \
          (git stash && git rebase origin/$branch && git stash pop); \
        git push origin $branch; \
      }; f";
    };
    extraConfig = {
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RF";
      };
      interactive = {
        diffFilter = "diff-so-fancy --patch";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
