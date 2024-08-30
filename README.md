# Nix and Home Manager Configurations

## Overview

This configuration uses [Nix](https://nixos.org/), [Home Manager](https://github.com/nix-community/home-manager), and [nix-darwin](https://github.com/LnL7/nix-darwin) to manage system and user configurations across different machines.

## Prerequisites

- [Nix](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [nix-darwin](https://github.com/LnL7/nix-darwin) (on MacOS)

You can also install these using the install script

```bash
# note that a shell restart is required between these commands!
# use them one by one and reopen the terminal between them
./install.sh nix
./install.sh darwin
./install.sh home-manager
```

Also make sure you have [Flakes](https://nixos.wiki/wiki/Flakes) enabled you can also set the `NIX_CONFIG` environment variable in your current shell:

```bash
# Should be 2.4+
nix --version
export NIX_CONFIG="experimental-features = nix-command flakes"
```

## Usage

This is basic usage of already created configurations, see [Customization](https://github.com/irohn/nix?tab=readme-ov-file#customization) section for adding your own configurations

### Home Manager

To build and activate a Home Manager configuration:

```bash
home-manager switch --flake .#<config-name>
```

Note that if you are not managing your users with nixos or darwin-nix, and you are customizing any shells with home-manager, you will have to manually set your user's shell with nix's shell, for example, with zsh:

```bash
# after running:
# $ home-manager switch --flake .#<config-name>
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

### Darwin

To build and activate a Darwin configuration:

```bash
darwin-rebuild switch --flake .#<config-name>
```

### NixOS

Work in progress...

## Customization

### Structure

```
├── flake.nix # The main entry point for the Nix flake
├── home-manager # Home Manager configurations
│   ├── home.nix # main configuration file
│   └── modules # configuration modules for home-manager
│       ├── module1
│       └── module2
├── darwin # Darwin configurations
│   ├── configuration.nix # Main configuration file
│   └── modules # darwin configuration modules
│       ├── module1
│       └── module2
└── nixos # NixOS configurations
    ├── configuration.nix # main configuration file
    └── modules # nixos configuration modules
        ├── module1
        └── module2
```

### Adding a New User Configuration

in `flake.nix`, add a new user and their configurations, for example:

```nix
# ... previous code ...

      commonModules = {
        ori = { ... };
        alice = {
          homeManager = [
            ./home-manager/modules/git
            ./home-manager/modules/zsh
            ./home-manager/modules/tmux
          ];
        };
      };

# ... previous code ...

      homeConfigurations = {
        # ... existing configurations ...
        alice-laptop = mkHomeConfiguration {
          system = "x86_64-linux";
          username = "alice";
          email = "alice@example.com";
          extraModules = [ ];
        };
      };

# ... previous code ...

      darwinConfigurations = {
        # ... existing configurations ...
        alice-macbook = mkDarwinConfiguration {
          system = "aarch64-darwin";
          username = "alice";
          email = "alice@example.com";
          extraModules = [
            ./darwin/modules/system
            ./darwin/modules/apps
          ];
        };
      };

# ... rest of flake.nix ...
```

### Adding a New Module

1. Create a new module file, e.g., `home-manager/modules/tmux/default.nix`:

```nix
{ config, lib, pkgs, ... }:

{
  options.programs.tmux = {
    enable = lib.mkEnableOption "tmux terminal multiplexer";
    shortcut = lib.mkOption {
      type = lib.types.str;
      default = "a";
      description = "Set prefix key to Ctrl+<shortcut>";
    };
  };

  config = lib.mkIf config.programs.tmux.enable {
    home.packages = [ pkgs.tmux ];
    home.file.".tmux.conf".text = ''
      set -g prefix C-${config.programs.tmux.shortcut}
      unbind C-b
      bind C-${config.programs.tmux.shortcut} send-prefix
    '';
  };
}
```

2. Add the module to a user configuration in `flake.nix` like `commonModules` or `extraModules`:

```nix
      commonModules = {
        ori = {
          homeManager = [
            # ... existing modules ...
            ./home-manager/modules/tmux
          ];
        };
      };
```

## TODO

- Add NixOS configurations
- Implement Darwin-specific modules (system, apps, etc.)
- Combine overlapping arguments in configurations

