#!/bin/bash

# Get absolute path of the Games folder
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


PREFIX_NAME="Cyberpunk"    #Change to desired name


export WINEPREFIX="$BASE_DIR/prefixes/$PREFIX_NAME"

[ -f "$BASE_DIR/global.conf" ] && source "$BASE_DIR/global.conf"

# Initialize the environment
umu-run ""

echo "Prefix initialized at $WINEPREFIX"
