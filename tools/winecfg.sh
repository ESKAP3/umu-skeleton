#!/bin/bash

# Setup paths based on your skeleton structure
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_DIR="$(dirname "$SCRIPT_DIR")"


WINEPREFIX="$BASE_DIR/prefixes/Cyberpunk"     #Replace with Prefix name


export WINEPREFIX="${WINEPREFIX%/}"

[ -f "$BASE_DIR/global.conf" ] && source "$BASE_DIR/global.conf"

umu-run winecfg
