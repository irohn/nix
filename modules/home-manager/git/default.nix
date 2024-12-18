# Distributed version control system
{
  pkgs,
  username,
  email,
  ...
}:

{
  home.packages = with pkgs; [
    gh # github cli
  ];

  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    extraConfig = {
      pull = {
        rebase = true;
      };
    };
  };
}
