# Nix
My nix configurations

## Environments
Currently these are the supported environments:
- linux-x86
- darwin-aarch64

## Usage
Install Nix and home-manager with the install script:
```
./install.sh
```
Or install [nix](https://nixos.org/download/) (the package-manager or NixOS)
as well as [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) yourself (standalone method)

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

Lastly, if you are not managing your system configuration with nixos or darwin-nix make sure to add the new shell as default for the user:
```
echo "$(which zsh)" | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

