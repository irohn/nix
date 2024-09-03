# A smarter cd command that learns your habits
{
  pkgs,
  ...
}: {
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = {
      cd = "__zoxide_z";
    };
  };
}
