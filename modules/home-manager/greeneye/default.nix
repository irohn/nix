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
    coreutils
    gawk
    fzf
    fd
    ripgrep
    kubectl
    tailscale
    vault
    azure-cli
    # google-cloud-sdk
  ];

  home.file = {
    ".config/greeneye/bin" = {
      source = "${greenix}/bin";
      recursive = true;
    };
    ".config/greeneye/scripts" = {
      source = "${greenix}/scripts";
      recursive = true;
    };

    ".config/greeneye/git/config" = {
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
        path = "~/.config/greeneye/git/config";
      }
    ];
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/greeneye/bin"
  ];

}
