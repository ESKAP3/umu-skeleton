#!/bin/bash

# Get absolute path of the Games folder
export BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


export PREFIX_NAME="Cyberpunk"    #Change to desired name


export WINEPREFIX="$BASE_DIR/prefixes/$PREFIX_NAME"

[ -f "$BASE_DIR/global.conf" ] && source "$BASE_DIR/global.conf"

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
