#!/usr/bin/env bash

# defaults
SYSTEM="nixos"
CONFIG=""

function show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --config, -c        Specify the configuration. Example: --config=macbook"
    echo "  --system, -s        Specify the system. Options are 'nixos' (default) or 'darwin'"
    echo "  --help, -h          Show this help message and exit"
    echo ""
}

# Detect MacOS
if [[ "$OSTYPE" == "darwin"* ]]; then
	SYSTEM="darwin"
	CONFIG="macbook"
fi

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
	case $1 in
		--config|-c)
			shift
			CONFIG="#$1"
			;;
		--system|-s)
			shift
			SYSTEM="$1"
			;;
		--help|-h)
			show_help
			exit 0
			;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
			;;
	esac
	shift
done

if [[ "$SYSTEM" == "home-manager" ]]; then
	SYSTEM_CMD="$SYSTEM"
else
	SYSTEM_CMD="$SYSTEM-rebuild"
fi

CONFIG_CMD="#${CONFIG}"

COMMAND="${SYSTEM_CMD} switch --flake .\?submodules=1${CONFIG_CMD}"
eval $COMMAND
