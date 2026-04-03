#!/bin/bash

# Get absolute path of the Games folder
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


export PREFIX_NAME="Cyberpunk"    #Change to desired name


export WINEPREFIX="$SCRIPT_DIR/prefixes/$PREFIX_NAME"

# Initialize the environment
umu-run ""

# Wait for filesystem to exist
while [ ! -f "$WINEPREFIX/system.reg" ]; do
    sleep 0.5
done

sleep 0.5

# Standard wine prefix update/check
umu-run wineboot -u

echo "Prefix initialized at $WINEPREFIX"
