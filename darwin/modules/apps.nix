{
  pkgs,
  ...
}: {
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html

  # Install packages from nix's official package repository.

  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  environment.systemPackages = with pkgs; [
    git
    curl
    vim
  ];

  # Homebrew need to be installed manually, see https://brew.sh
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "hashicorp/tap"
    ];

    # `brew install`
    brews = [
      "hashicorp/tap/hcp"
    ];

    # `brew install --cask`
    casks = [
      "alt-tab" # Windows 11 style alt+tab
      "wezterm" # GPU accelerated terminal emulator (config in home-manager)
      "karabiner-elements" # Keyboard manager
      "rectangle" # Window snapping app with keybindings
      "mac-mouse-fix" # Fix mouse scrolling
      "raycast" # Spotlight alternative
      "caffeine" # Prevent screen from turning off
      "docker" # Docker Desktop
      "xquartz"

      # AI
      "ollama"

      # Gaming
      "steam"
      "discord"
    ];
  };
}
