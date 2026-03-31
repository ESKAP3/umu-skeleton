#!/bin/bash

# Local variable for calculation
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Exported for umu-run and child processes
export BASE_DIR="$(dirname "$SCRIPT_DIR")"

export WINEPREFIX="$BASE_DIR/prefixes/Cyberpunk"   #Change Cyberpunk to your prefix name

export PROTONPATH="$BASE_DIR/runners/current"    #Points to symlink for global runner swap

#export MANGOHUD=1     #Uncomment to use Mangohud

# Shader cache setup (prevents clutter)
export VKD3D_SHADER_CACHE_PATH="$WINEPREFIX/vkd3d_cache_umu"
mkdir -p "$VKD3D_SHADER_CACHE_PATH"

# You can use an absolute path if you want
umu-run "$WINEPREFIX/drive_c/Games/Cyberpunk 2077/bin/x64/Cyberpunk2077.exe" #2>&1 | tee "$SCRIPT_DIR/last_run.log"   #Uncomment for log

