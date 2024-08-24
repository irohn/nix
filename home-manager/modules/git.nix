{ config, pkgs, lib, defaults, ... }:

{
  programs.git = {
    enable = true;
    userName = defaults.username;
    userEmail = defaults.email;
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
      pull = {
        rebase = true;
      };
    };
  };
}
