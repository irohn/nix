# Nix and Home Manager Configurations

## Overview

A [Nix](https://nixos.org/) [flake](https://nixos.wiki/wiki/Flakes) holding [NixOS](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager) configurations.

## Prerequisites

- git
- curl
- [nix](https://nixos.org/download/#nix-install-linux)
- [nixos](https://nixos.org/download/#nixos-iso) (required for NixOS hosts)
- [nix-darwin](https://github.com/LnL7/nix-darwin) (required for MacOS hosts)
- [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone) (required for users configurations, standalone setup recommended)

## Usage
There are different commands for different uses, however, first clone the repository and change directory into it:

```bash
git clone https://github.com/irohn/nix.git ~/nix
cd ~/nix
```

### home-manager
To use home-manager standalone, after installation, you can run:

```nix
home-manager switch --flake .#ori
```

If you have a different user defined in the flake, you can change `ori` to your selected user.

### nix-darwin
Darwin uses a slightly different command:

```nix
darwin-rebuild switch --flake .#macbook
```

If you have a different MacOS machine defined the the flake, you can change `macbook` to your selected machine.

### nixos
For nixos simply run
```nix
sudo nixos-rebuild switch --flake .#desktop
```

If you have a different machine defined the the flake, you can change `desktop` to your selected machine.

## Structure

The repository is structured as follows:
```
.
├── hosts                    # Machines configurations
│   ├── desktop              # NixOS machine
│   └── macbook              # MacOS machine
├── modules                  # Portable modules
│   ├── common               # Shared modules
│   ├── darwin               # Darwin specific modules
│   ├── home-manager         # home-manager specific modules
│   └── nixos                # nixos specific modules
├── secrets                  # encrypted secrets
│   └── secrets.nix          # Secrets specifications for encryption
├── users                    # Users confugrations for home-manager
│   └── ori
└── flake.nix                # Main flake
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
