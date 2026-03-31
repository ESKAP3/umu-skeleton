#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Replace 'xx' with the prefix of the stuck game
export WINEPREFIX="$SCRIPT_DIR/prefixes/xx"

# Kill it
umu-run wineserver -k

echo "Environment $WINEPREFIX shut down."
