#!/usr/bin/env sh

set -eu

_print_help() {
    cat << EOF
Usage: $0 [options]

Install Nix package manager and Home Manager (standalone)

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

_install_nix() {
    echo "Installing Nix..."
    
    if ! command -v curl >/dev/null 2>&1; then
        echo "Error: curl is required but not installed. Please install curl and try again."
        exit 1
    fi

    curl -L https://nixos.org/nix/install | sh -s -- --daemon

    # Source nix
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

_install_home_manager() {
    echo "Installing Home Manager..."
    
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix-shell '<home-manager>' -A install
}

_check_os() {
    if [ "$(uname)" = "Darwin" ]; then
        echo "macOS detected"
    elif [ "$(uname)" = "Linux" ]; then
        echo "Linux detected"
    else
        echo "Error: Unsupported operating system. This script only works on macOS and Linux."
        exit 1
    fi
}

_main() {
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
            *)
                echo "Unknown option: $1"
                _print_help
                exit 1
                ;;
        esac
        shift
    done

    # Debug mode
    if [ "${DEBUG:-}" = "true" ]; then
        set -x
    fi

    _check_os

    if _check_nix_installed; then
        echo "Skipping Nix installation."
    else
        _install_nix
    fi

    # Re-check Nix installation before proceeding to Home Manager
    if ! _check_nix_installed; then
        echo "Error: Nix installation failed. Please check the logs and try again."
        exit 1
    fi

    if _check_home_manager_installed; then
        echo "Skipping Home Manager installation."
    else
        _install_home_manager
    fi

    echo "Nix and Home Manager installation process completed!"
    echo "Please restart your shell or run 'source $HOME/.nix-profile/etc/profile.d/nix.sh' to use Nix."
}

_main "$@"
