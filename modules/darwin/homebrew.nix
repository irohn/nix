{ ... }:

{
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html

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
      "hashicorp/tap/vault"
      "qemu"
      "lima"
    ];

    # `brew install --cask`
    casks = [
      "alt-tab" # Windows 11 style alt+tab
      "karabiner-elements" # Keyboard manager
      "raycast" # Spotlight alternative
      "keepingyouawake" # Prevent screen from turning off
      "xquartz" # X11 server
      "iina" # Modern media player
      "gimp" # Image editor
      "1password" # Password Manager
      "stremio" # streaming
      "rectangle-pro" # Window manager
      "ghostty"
      "rustdesk" # remote desktop
      "firefox"
      "docker"
    ];
  };
}
