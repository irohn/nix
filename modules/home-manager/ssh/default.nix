{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "irohn" = {
        user = "git";
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
