# Custom module for greeneye specific needs
{
  pkgs,
  config,
  greenix,
  email,
  ...
}:

{
  # Dependencies
  home.packages = with pkgs; [
    fd
    ripgrep
    tailscale
    azure-cli
    kubectl
    gawk
    fzf
    coreutils
    vault
    google-cloud-sdk
  ];

  home.file = {
    ".local/bin/greeneye" = {
      source = "${greenix}";
      recursive = true;
    };

    ".config/git/greeneye/config" = {
      text = ''
        [user]
            name = ori
            email = ${email.work}
        [core]
            sshcommand = ssh -i ~/.ssh/greeneye_id_ed25519 -F /dev/null
      '';
    };
  };

  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/greeneye_config" ];
  };

  programs.git = {
    enable = true;
    includes = [
      {
        condition = "gitdir:~/projects/greeneye/**";
        path = "~/.config/git/greeneye/config";
      }
    ];
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin/greeneye/bin"
    "${config.home.homeDirectory}/.local/bin/greeneye/scripts"
  ];

}
