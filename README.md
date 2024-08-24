# nix
My nix configurations

### Environments
Currently these are the supported environments:
- linux-x86
- darwin-aarch64

### Usage
Make sure you're running Nix 2.4+, and opt into the experimental flakes and nix-command features:
```
# Should be 2.4+
nix --version
export NIX_CONFIG="experimental-features = nix-command flakes"
```

- Run sudo nixos-rebuild switch --flake .#<environment> to apply your system configuration.
- Run home-manager switch --flake .#<environment> to apply your home configuration.
