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
    userEmail = email.personal;
    extraConfig = {
      pull = {
        rebase = true;
      };
      core = {
        sshcommand = "ssh -i ~/.ssh/id_ed25519 -F /dev/null";
      };
    };
  };
}
