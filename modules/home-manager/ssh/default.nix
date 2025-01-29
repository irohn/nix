{ ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    matchBlocks = {
      greeneye = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/greeneye_id_ed25519";
      };
    };
  };
}
