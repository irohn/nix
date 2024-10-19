#!/usr/bin/env bash

# defaults
SYSTEM="nixos"
CONFIG=""

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
		*) echo "Unknown parameter passed: $1"; exit 1 ;;
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
