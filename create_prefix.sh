#!/bin/bash

# Get absolute path of the Games folder
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Replace 'xx' with your desired game prefix name
export WINEPREFIX="$SCRIPT_DIR/prefixes/xx"
export PROTONPATH="$SCRIPT_DIR/runners/current"

# Start the umu environment
umu-run ""

# Wait for filesystem to exist
while [ ! -f "$WINEPREFIX/system.reg" ]; do
    sleep 0.5
done

sleep 1

# Standard wine update/init
umu-run wineboot -u

sleep 0.5
echo "Prefix initialized at $WINEPREFIX"
