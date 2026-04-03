#!/bin/bash

# Local variable for calculation
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Exported for umu-run and child processes
export BASE_DIR="$(dirname "$SCRIPT_DIR")"

export LOG_DIR="$BASE_DIR/.logs"    #Define the Log Directory
mkdir -p "$LOG_DIR"


WINEPREFIX="$BASE_DIR/prefixes/Cyberpunk"    #CHANGE "Cyberpunk" TO YOUR PREFIX NAME


export WINEPREFIX="${WINEPREFIX%/}"

export PREFIX_NAME="${WINEPREFIX##*/}"     #name logs based on prefix

# Shader cache setup (prevents clutter)
export VKD3D_SHADER_CACHE_PATH="$WINEPREFIX/vkd3d_cache_umu"
mkdir -p "$VKD3D_SHADER_CACHE_PATH"

# --- GLOBAL CONFIG ---
# We use 'source' to pull in variables. 
# That file doesn't need to be executable and shouldn't be run directly.
[ -f "$BASE_DIR/global.conf" ] && source "$BASE_DIR/global.conf"

# You can also use an absolute path if you want, but that breaks portability when moving the directory.
umu-run "$WINEPREFIX/drive_c/Games/Cyberpunk 2077/bin/x64/Cyberpunk2077.exe" #2>&1 | tee "$LOG_DIR/last_run_$PREFIX_NAME.log"    #Uncomment for log
