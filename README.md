# Nix and Home Manager Configurations

## Overview

This configuration uses [Nix](https://nixos.org/), [Home Manager](https://github.com/nix-community/home-manager), and [nix-darwin](https://github.com/LnL7/nix-darwin) to manage system and user configurations across different machines using [flakes](https://nixos.wiki/wiki/Flakes).

## Prerequisites

- git
- curl

## Installation

Clone this repository and change directory into it:

```bash
git clone https://github.com/irohn/nix.git ~/nix && cd ~/nix
```

### nix

First thing first, if you are not on NixOS, install Nix itself. There is an install script provided in the repository

```bash
chmod +x ./install
./install nix
```

Once nix is installed, restart your shell and verify installation:

```bash
cd ~/nix
nix --version # Should be 2.4+
nix flake info # Show flake metadata
```

### home-manager

After installing nix, we can install home-manager using flakes:

```bash
cd ~/nix
./install home-manager
```

This should have installed home-manager as well as created your first generation! Once installed restart your shell and verify installation:

```bash
home-manager --version
```

### darwin

After installing nix, we can install nix-darwin using flakes:

```bash
cd ~/nix
./install -c <config_name> darwin
```

Note that the `<config_name>` is the darwinConfiguration described in the flake.nix for example:

```nix
/* rest of your flake.nix ... */

      darwinConfigurations = {
        /* `alice` would be the <config_name> in this case */
        alice = mkDarwinConfiguration {
          system = settings.defaults.system;
          username = settings.defaults.username;
          hostname = "MacBookPro";
          email = settings.defaults.email;
          extraModules = [ ];
        };
      };

/* rest of your flake.nix ... */
```

To make your own configuration see [Customization](#Customization)

Once installed restart your shell and verify installation:

```bash
darwin-version --version
```

## Usage

This is basic usage of already created configurations, see [Customization](#Customization) section for adding your own configurations

### Home Manager

To build and activate a Home Manager configuration:

```bash
home-manager switch --flake .#<config-name>
```

Note that if you are not managing your users with nixos or darwin-nix, and you are customizing any shells with home-manager, you will have to manually set your user's shell with nix's shell after running the home-manager switch command, for example, with zsh:

```bash
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

Then restart your shell and you should see your new prompt activated

### Darwin

To build and activate a darwin configuration:

```bash
darwin-rebuild switch --flake .#<config-name>
```

Note that darwin-rebuild now integrates home-manager, this means that if you are running darwin-rebuild you don't need to run home-manager switch.

### NixOS

Work in progress...

## Customization

### Settings customizations

In `flake.nix`, change the default settings to your own:

```nix
# flake.nix
/* rest of your flake.nix ... */

      # Define your default settings here
      # these will be available as inputs for your modules
      settings = {
        defaults = {
          username = "alice";
          email = "alice@wonderland.com";
          system = "x86_64-linux";
        };
      };

/* rest of your flake.nix ... */
```

Then you can add the relevant configuration, there are some helper functions defined to help you create your configurations easier, for example, for home-manager we can use the mkHomeConfiguration, for darwin we can use the mkDarwinConfiguration and for nixos we can use the mkNixosConfiguration, here are some examples:

```nix
/* rest of your flake.nix ... */

      homeConfigurations = {
        alice = mkHomeConfiguration {
          system = settings.defaults.system;
          username = settings.defaults.username;
          email = settings.defaults.email;
          extraModules = [ ];
        };
      };

      darwinConfigurations = {
        alice = mkDarwinConfiguration {
          system = settings.defaults.system;
          username = settings.defaults.username;
          hostname = "MacBookPro";
          email = settings.defaults.email;
          extraModules = [ ];
        };
      };

      nixosConfigurations = {
        alice = mkNixosConfiguration {
          system = settings.defaults.system;
          username = settings.defaults.username;
          hostname = "AlicesLaptop";
          email = settings.defaults.email;
          extraModules = [ ];
        };
      };

/* rest of your flake.nix ... */
```

If you have multiple environments / computers you can define more specific names, instead of alice, you can do alice-macbook and alice-dell for different laptops etc...

## Modules

### Adding or removing existing modules

Most modules will be imported in the respective configuration's main nix file, home.nix for home-manager and configuration.nix for darwin and nixos. You can simply remove / add a module in the `imports` list and rebuild your system / home to update it

Some modules like agenix, are loaded in flake.nix in the `modules` list inside the helper functions themselves, this is generally not recommended, but sometimes unavoidable if you need a customization at the flake's level (like the ${system} substitute for agenix)

### Creating a custom module

Creating your own module is a great way to extend your configuration, you can also use existing modules from the internet using nix's amazing capabilities, or you can create a local module, for example, see the `eza` module for home-manager:

1. Create a new module file, e.g., `home-manager/modules/eza/default.nix`:

```nix
# A modern replacement for 'ls' with color support and Git integration
{
  pkgs,
  ...
}: {
  programs = {

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = true;
      extraOptions = [
        "--color-scale"
        "--group-directories-first"
      ];
    };

    zsh.shellAliases = {
      ls = "eza";
      ll = "eza -lAh";
      la = "eza -laa";
      lt = "eza --almost-all --tree --color=auto --icons=auto --git-ignore --smart-group --mounts --level=5";
    };
  };
}
```

2. Then import that module in one of the many available ways depending on your needs `[ ... ./modules/eza ... ];`
  - in `home.nix` imports list
  - in `flake.nix` as an extraModule for a specific configuration

## TODO

- Add NixOS configurations

