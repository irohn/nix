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
  ];

  home.file = {
    ".local/bin/greeneye" = {
      source = "${greenix}";
      recursive = true;
    };
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin/greeneye/bin"
    "${config.home.homeDirectory}/.local/bin/greeneye/scripts"
  ];

}
