{
  pkgs,
  system,
  ...
}: {
  #  macOS's System configuration

  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  system = {
    defaults = {
      NSGlobalDomain = {
        _HIHideMenuBar = true;
        NSAutomaticCapitalizationEnabled = false;  # disable auto capitalization
        NSAutomaticDashSubstitutionEnabled = false;  # disable auto dash substitution
        NSAutomaticPeriodSubstitutionEnabled = false;  # disable auto period substitution
        NSAutomaticQuoteSubstitutionEnabled = false;  # disable auto quote substitution
        NSAutomaticSpellingCorrectionEnabled = false;  # disable auto spelling correction
      };
      menuExtraClock.Show24Hour = true;  # show 24 hour clock
      dock = {
        autohide = true;
        orientation = "left";
        show-process-indicators = false;
        show-recents = false;
        static-only = true;
      };
      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;  # show status bar
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;  # enable quit menu item
      };
      trackpad = {
        Clicking = true;  # enable tap to click
        TrackpadRightClick = true;  # enable two finger right click
      };
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = 0; # Show items on desktop
          HideDesktop = 0; # Do not hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
      };
      loginwindow = {
        GuestEnabled = false;  # disable guest user
        SHOWFULLNAME = true;  # show full name in login window
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs = {
    zsh.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };
}
