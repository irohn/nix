# Nix and Home Manager Configurations

This repository contains Nix, Home Manager, and Darwin configurations for managing system and user environments.

## Overview

This configuration uses [Nix](https://nixos.org/), [Home Manager](https://github.com/nix-community/home-manager), and [nix-darwin](https://github.com/LnL7/nix-darwin) to manage system and user configurations across different machines.

## Prerequisites

- nix
- home-manager
- nix-darwin (on MacOS)

You can also install these using the install script

```bash
# note that a shell restart is required between these commands!
# use them one by one and reopen the terminal between them
./install.sh nix
./install.sh darwin
./install.sh home-manager
```

Also make sure you have [Flakes](https://nixos.wiki/wiki/Flakes) enabled you can also set the `NIX_CONFIG` environment variable:

```bash
# Should be 2.4+
nix --version
export NIX_CONFIG="experimental-features = nix-command flakes"
```

## Usage

Each command will be suffixed by a `.#<config-name>` these are defined in the main `flake.nix` (the one in the root of the repository) the examples shown are a specific configuration, change them according to your own.

### Home Manager

To build and activate a Home Manager configuration:

```bash
home-manager switch --flake .#ori-macbook
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
darwin-rebuild switch --flake .#ori-macbook
```

### NixOS

Work in progress...

### Structure
- `flake.nix`: The main entry point for the Nix flake
- `home-manager/`: Contains Home Manager configurations
    - `home.nix`: Main Home Manager configuration file
    - `modules/`: Directory containing various configuration modules
- `darwin`: Contains Darwin-specific configurations
    - `configuration.nix`: Main Darwin configuration file
    - `modules/`: Directory containing various configuration modules
- `nixos`: Contains NixOS-specific configurations
    - `configuration.nix`: Main NixOS configuration file
    - `modules/`: Directory containing various configuration modules

### Customization

To add a new user or modify existing configurations:
1. Add the user's common modules to the `commonModules` attribute in `flake.nix`
2. Create new configurations in `homeConfigurations`, `nixosConfigurations` and/or `darwinConfigurations` as needed


## TODO

Add NixOS configurations
Implement Darwin-specific modules (system, apps, etc.)
Combine overlapping arguments in configurations

