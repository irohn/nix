# Nix
My nix configurations

## Environments
Currently these are the supported environments:
- linux-x86
- darwin-aarch64

## Usage
Install [nix](https://nixos.org/download/) (the package-manager or NixOS)

Clone this repository:
```
git clone https://github.com/irohn/nix.git ~/nix-config && cd ~/nix-config
```

Make sure you're running Nix 2.4+, and opt into the [experimental flakes and nix-command](https://nixos.wiki/wiki/Flakes) features:
```
# Should be 2.4+
nix --version
export NIX_CONFIG="experimental-features = nix-command flakes"
```

- Run `sudo nixos-rebuild switch --flake ~/nix-config#<environment>` to apply your system configuration.
- Run `home-manager switch --flake ~/nix-config#<environment>` to apply your home configuration.

