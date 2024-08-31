#!/usr/bin/env sh

set -eu

_print_help() {
    cat << EOF
Usage: $0 [options] <component>

Install Nix package manager, Home Manager (standalone), or nix-darwin

Components:
    nix             Install Nix package manager
    home-manager    Install Home Manager
    darwin          Install nix-darwin (macOS only)

Options:
    -h, --help      Show this help message and exit
    -d, --debug     Enable debug mode
EOF
}

_check_nix_installed() {
    if command -v nix >/dev/null 2>&1; then
        echo "Nix is already installed."
        return 0
    else
        return 1
    fi
}

_check_home_manager_installed() {
    if command -v home-manager >/dev/null 2>&1; then
        echo "Home Manager is already installed."
        return 0
    else
        return 1
    fi
}

_check_darwin_installed() {
    if command -v darwin-rebuild >/dev/null 2>&1; then
        echo "nix-darwin is already installed."
        return 0
    else
        return 1
    fi
}

_install_nix() {
    echo "Installing Nix..."

    if ! command -v curl >/dev/null 2>&1; then
        echo "Error: curl is required but not installed. Please install curl and try again."
        exit 1
    fi

    curl -L https://nixos.org/nix/install | sh -s -- --daemon

    echo "Nix installation completed!"
    echo "Please restart your shell or run 'source $HOME/.nix-profile/etc/profile.d/nix.sh' to use Nix."
}

_install_home_manager() {
    echo "Installing Home Manager..."

    if ! _check_nix_installed; then
        echo "Error: Nix is required but not installed. Please install Nix first using '$0 nix'."
        exit 1
    fi

    # Source nix
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"

    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update

    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install

    echo "Home Manager installation completed!"
}

_install_darwin() {
    echo "Installing nix-darwin..."

    if ! _check_nix_installed; then
        echo "Error: Nix is required but not installed. Please install Nix first using '$0 nix'."
        exit 1
    fi

    # Source nix
    if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi

    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer

    echo "nix-darwin installation completed!"
}

_check_os() {
    if [ "$(uname)" = "Darwin" ]; then
        echo "macOS detected"
        IS_MACOS=true
    elif [ "$(uname)" = "Linux" ]; then
        echo "Linux detected"
        IS_MACOS=false
    else
        echo "Error: Unsupported operating system. This script only works on macOS and Linux."
        exit 1
    fi
}

_main() {
    local COMPONENT=""
    local IS_MACOS=false

    # Parse command-line arguments
    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                _print_help
                exit 0
                ;;
            -d|--debug)
                DEBUG=true
                ;;
            nix|home-manager|darwin)
                COMPONENT="$1"
                ;;
            *)
                echo "Unknown option or component: $1"
                _print_help
                exit 1
                ;;
        esac
        shift
    done

    # Check if a component was specified
    if [ -z "$COMPONENT" ]; then
        echo "Error: No component specified."
        _print_help
        exit 1
    fi

    # Debug mode
    if [ "${DEBUG:-}" = "true" ]; then
        set -x
    fi

    _check_os

    case "$COMPONENT" in
        nix)
            if _check_nix_installed; then
                echo "Nix is already installed. Skipping installation."
            else
                _install_nix
            fi
            ;;
        home-manager)
            if _check_home_manager_installed; then
                echo "Home Manager is already installed. Skipping installation."
            else
                _install_home_manager
            fi
            ;;
        darwin)
            if [ "$IS_MACOS" = false ]; then
                echo "Error: nix-darwin can only be installed on macOS."
                exit 1
            fi
            if _check_darwin_installed; then
                echo "nix-darwin is already installed. Skipping installation."
            else
                _install_darwin
            fi
            ;;
    esac
}

_main "$@"
