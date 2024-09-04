# A smarter cd command that learns your habits
{
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
