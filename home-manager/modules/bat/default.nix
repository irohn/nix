# A cat clone with syntax highlighting and Git integration
{
  ...
}: {
  programs = {
    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "plain";
        theme = "TwoDark";
      };
    };

    zsh.shellAliases = {
      cat = "bat";
    };
  };
}
