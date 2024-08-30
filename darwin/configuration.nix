{ config, pkgs, lib, ... }:

{
  # Basic system configuration
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
  };

  # Enable Homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];
    brews = [
      # Add any Homebrew packages you want to install
    ];
    casks = [
      # Add any Homebrew casks you want to install
      "rectangle"
      "wezterm"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Add any system-wide packages here
    coreutils
    wget
    curl
  ];

  # Enable some system services
  services = {
    nix-daemon.enable = true;
    };
  };

  # Configure Nix
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
