# Nix and Home Manager Configurations

## Overview

This configuration uses [Nix](https://nixos.org/), [Home Manager](https://github.com/nix-community/home-manager), and [nix-darwin](https://github.com/LnL7/nix-darwin) to manage system and user configurations across different machines.

## Prerequisites

- [Nix](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)
- [nix-darwin](https://github.com/LnL7/nix-darwin) (on MacOS)
- Enable [Flakes](https://nixos.wiki/wiki/Flakes) (Optional but recommended)
- [NerdFonts](https://www.nerdfonts.com/) installed and enabled on your terminal emulator

## Installation

### nix

First thing first, if you are not on NixOS, install Nix itself:

```bash
./install nix
```

Once nix is installed, restart your shell and verify installation:

```bash
nix --version # Should be 2.4+
nix flake info # Show flake metadata
```

### home-manager

After installing nix, we can install home-manager using flakes:

```bash
./install home-manager
```

This should have installed home-manager as well as created your first generation!
Once installed restart your shell and verify installation:

```bash
home-manager --version
```

### darwin

After installing nix, we can install nix-darwin using flakes:

```bash
./install darwin
```

Once installed restart your shell and verify installation:

```bash
darwin-version --version
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

then restart your shell and you should see your new prompt activated

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
│   ├── alice.nix # defaults home override for alice
│   └── modules # configuration modules for home-manager
│       ├── module1
│       └── module2
├── darwin # Darwin configurations
│   ├── configuration.nix # Main configuration file
│   ├── alice.nix # defaults darwin configuration override for alice
│   └── modules # darwin configuration modules
│       ├── module1
│       └── module2
└── nixos # NixOS configurations
    ├── configuration.nix # main configuration file
│   ├── alice.nix # defaults nixos configuration override for alice
    └── modules # nixos configuration modules
        ├── module1
        └── module2
```

### Adding a New User Configuration

in `flake.nix`, add a new user and their configurations, for example:

```nix
# flake.nix
# ... previous code ...

      # Define user level settings
      settings = {
        example = {
          defaults = {
            username = "exam";
            email = "example@mail.com";
            # get this with `nix eval --impure --raw --expr 'builtins.currentSystem'`
            system = "x86_64-linux";
          };
          modules = {
            homeManager = [ ./home-manager/alice.nix ];
            darwin = [ ./darwin/alice.nix ];
            nixos = [ ./nixos/alice.nix ];
          };
        };
      };

# ... previous code ...

      homeConfigurations = {
        # ... existing configurations ...
        alice-laptop = mkHomeConfiguration {
          system = "x86_64-linux";
          username = "alice";
          email = "alice@example.com";
          extraModules = [
            ./home-manager/modules/greeneye # load the greeneye module specifically on alice's laptop home config
          ]; # Extra modules that applies just for alice-laptop home config
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
            ./darwin/modules/custom_module # Module that applies specifically to alice-macbook darwin config
          ];
        };
      };

# ... rest of flake.nix ...
```

Then in <config>/alice.nix for example `./home-manager/alice.nix` you can import all default modules for alice's home configuration

```nix
# ./home-manager/alice.nix
{ config, pkgs, username, email, ... }:

{
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
  ];
}
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

2. Then import that module in one of the many available ways depending on your needs
  - in `flake.nix` settings.<name>.modules.home-manager = [ ... ./home-manager/modules/tmux ... ];
  - in `flake.nix` as an extraModule in machine scope (e.g. alice-laptop)
  - as a default module for a user for example `home-manager/alice.nix` in the imports list

## TODO

- Add NixOS configurations

