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
    wezterm # GPU accelerated terminal emulator (config in home-manager)
    utm
    discord
    pam-reattach # Touch ID support in tmux
  ];

  # Hack to make pam-reattach work
  environment.etc."pam.d/sudo_local".text = ''
    # Written by nix-darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
  '';

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
      "karabiner-elements" # Keyboard manager
      "mac-mouse-fix" # Fix mouse scrolling
      "raycast" # Spotlight alternative
      "keepingyouawake" # Prevent screen from turning off
      "xquartz" # X11 server
      "mullvadvpn" # VPN client
      "iina" # Modern media player
      "rectangle-pro" # Window manager

      # Development
      "docker" # Docker Desktop
      "visual-studio-code"

      # AI
      "ollama"
      "diffusionbee"

      # Gaming
      "steam"
      "whisky"
    ];
  };
}
