# Nix and Home Manager Configurations

## Overview

A Nix [Flake](https://nixos.wiki/wiki/Flakes) holding [NixOS](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager) configurations.

## Prerequisites

- git
- curl
- [nix](https://nixos.org/download/#nix-install-linux)
- [nixos](https://nixos.org/download/#nixos-iso) (required for NixOS hosts)
- [nix-darwin](https://github.com/LnL7/nix-darwin) (required for MacOS hosts)
- [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone) (required for users configurations, standalone setup recommended)

## Install Nix
Using [DeterminateSystems](https://github.com/DeterminateSystems/nix-installer) installer:
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

## Usage
There are different commands for different uses, however, first clone the repository and change directory into it:

```bash
git clone https://github.com/irohn/nix.git ~/nix
cd ~/nix
```

### home-manager
To use home-manager standalone, after installation, you can run:

```nix
home-manager switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')
```

Make sure the user defined in the flake has a module in `./users/<USERNAME>/default.nix`

### nix-darwin
Darwin uses a slightly different command:

```nix
darwin-rebuild switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')
```

### nixos
For nixos simply run
```nix
sudo nixos-rebuild switch --flake .#$(nix eval --impure --raw --expr 'builtins.currentSystem')
```

## Secrets

I am using [agenix](https://github.com/ryantm/agenix) for secrets management
to edit a secret or rekey all secrets with a new SSH key:

```bash
cd secrets

# edit a secret
nix run github:ryantm/agenix -- -e <secret-name>

# rekey secrets
nix run github:ryantm/agenix -- -r
```

To add and use secrets see the [agenix tutorial](https://github.com/ryantm/agenix?tab=readme-ov-file#tutorial)
