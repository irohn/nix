# Custom module for greeneye specific needs
{
  pkgs,
  config,
  greenix,
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

    ".config/git/greeneye/.gitconfig" = {
      text = ''
        [user]
          name = ori
          email = orisne@greeneye.ag
      '';
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    includes = [ "~/.ssh/greeneye_config" ];
    matchBlocks = {
      "greeneye" = {
        user = "git";
        hostname = "github.com";
        identityFile = "~/.ssh/greeneye_id_ed25519";
      };
    };
  };

  programs.git = {
    enable = true;
    includes = [
      {
        condition = "gitdir:~/projects/greeneye/**";
        path = "~/.config/git/greeneye/.gitconfig";
        contents = {
          user = {
            name = "ori";
            email = "orisne@greeneye.ag";
          };
          core = {
            sshcommand = "ssh -i ~/.ssh/greeneye_id_ed25519 -F /dev/null";
          };
        };
      }
    ];
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin/greeneye/bin"
    "${config.home.homeDirectory}/.local/bin/greeneye/scripts"
  ];

}
