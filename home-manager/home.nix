# home-manager configuration file
{
  pkgs,
  config,
  username,
  inputs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = config.nixpkgs.config;
  };
in {
  _module.args.pkgs-unstable = pkgs-unstable;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  imports = [
    ./modules/git
    ./modules/zsh
    ./modules/eza
    ./modules/bat
    ./modules/zoxide
    ./modules/fonts
    ./modules/starship
    ./modules/tmux
    ./modules/neovim
    ./modules/kubernetes
    ./modules/wezterm
    ./modules/greeneye
  ];

  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin
      then "/Users/${username}" else "/home/${username}";

    packages = with pkgs; [
      # Core packages
      curl
      wget
      vim
      fzf
      jq
      yq
      gawk # ensure gnu-awk for uniformity across systems
      unixtools.watch
    ];

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
