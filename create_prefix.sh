#!/bin/bash

# Get absolute path of the Games folder
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Replace 'xx' with your desired game prefix name
export WINEPREFIX="$SCRIPT_DIR/prefixes/xx"
export PROTONPATH="$SCRIPT_DIR/runners/current"

# Initialize the prefix environment
umu-run ""

# Wait for filesystem to exist
while [ ! -f "$WINEPREFIX/system.reg" ]; do
    sleep 0.5
done

sleep 1

# Standard wine prefix update/check
umu-run wineboot -u

echo "Prefix initialized at $WINEPREFIX"
