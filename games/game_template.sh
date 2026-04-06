#!/bin/bash

# Local variable for calculation
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_DIR="$(dirname "$SCRIPT_DIR")"

#Define the Log Directory
export LOG_DIR="$BASE_DIR/.logs"
# mkdir -p "$LOG_DIR"  #Uncomment for log


WINEPREFIX="$BASE_DIR/prefixes/Cyberpunk"     #CHANGE "Cyberpunk" TO YOUR PREFIX NAME


export WINEPREFIX="${WINEPREFIX%/}"

#name logs based on prefix
export PREFIX_NAME="${WINEPREFIX##*/}"

# Shader cache setup (prevents clutter)
export VKD3D_SHADER_CACHE_PATH="$WINEPREFIX/vkd3d_cache_umu"
mkdir -p "$VKD3D_SHADER_CACHE_PATH"

# --- GLOBAL CONFIG ---
# We use 'source' to pull in variables. 
# That file doesn't need to be executable and shouldn't be run directly.
[ -f "$BASE_DIR/global.conf" ] && source "$BASE_DIR/global.conf"


# Local Overrides for Gamemode/Gamescope

#ENABLE_GAMEMODE=1

#ENABLE_GAMESCOPE=1

GAMESCOPE_ARGS="-W 1920 -H 1080 -r 60 -F fsr"


CMD_PRE=""
if [ "$ENABLE_GAMEMODE" = "1" ] && command -v gamemoderun >/dev/null; then
    CMD_PRE="gamemoderun"
fi

if [ "$ENABLE_GAMESCOPE" = "1" ] && command -v gamescope >/dev/null; then
    CMD_PRE="${CMD_PRE} gamescope $GAMESCOPE_ARGS -- "
fi

# You can also use an absolute path if you want, but that breaks portability when moving the directory.
$CMD_PRE umu-run "$WINEPREFIX/drive_c/Games/Cyberpunk 2077/bin/x64/Cyberpunk2077.exe" #2>&1 | tee "$LOG_DIR/last_run_$PREFIX_NAME.log"    #Uncomment for log
