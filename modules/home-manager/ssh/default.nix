{ ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      irohn = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
      greeneye = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/greeneye_id_ed25519";
      };
    };
  };
}
