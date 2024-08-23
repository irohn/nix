# home-manager/home.nix

{ config, pkgs, username, lib, ... }:

let
  packageModules = [
    ./packages/base.nix
    ./packages/zsh.nix
    ./packages/starship.nix
    ./packages/kubernetes.nix
    ./packages/neovim.nix
    ./packages/tmux.nix
  ];

  allPackages = lib.flatten (map (module: (import module { inherit pkgs; }).home.packages) packageModules);
  uniquePackages = lib.unique allPackages;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = uniquePackages;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/bashrc' in
    # # the Nix store. Activating the configuration will then make '~/.bashrc' a
    # # symlink to the Nix store copy.
    # ".bashrc".source = dotfiles/bashrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/$USERNAME/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
