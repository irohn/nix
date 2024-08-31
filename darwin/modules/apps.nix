{ pkgs, ...}: {

  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html

  # Install packages from nix's official package repository.

  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.

  environment.systemPackages = with pkgs; [
    git
  ];

  # Homebrew need to be installed manually, see https://brew.sh

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # I mainly use this for GUI apps
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    brews = [
      "coreutils"
    ];

    # `brew install --cask`
    casks = [
      "alt-tab"
      "wezterm"
      "karabiner-elements"
      "rectangle"
      "scroll-reverser"
      "raycast"
    ];
  };
}
