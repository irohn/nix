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
    ./modules/direnv
    ./modules/eza
    ./modules/bat
    ./modules/zoxide
    ./modules/fonts
    ./modules/rsync
    ./modules/tmux
    ./modules/neovim
    ./modules/kubernetes
    ./modules/wezterm
    ./modules/greeneye
    ./modules/starship
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
      slides # terminal based slides
      gnupg
      sops
      coreutils
      gnumake
    ];

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
