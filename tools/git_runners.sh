#!/bin/bash

# Setup paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUNNERS_DIR="$(dirname "$SCRIPT_DIR")/runners"
mkdir -p "$RUNNERS_DIR"

echo "--- Runner Downloader ---"
echo "1) GE-Proton (GloriousEggroll)"
echo "2) Proton-EM (Etaash-mathamsetty)"
echo "3) Proton-CachyOS (CachyOS x86_64_v3)"
echo "4) Exit"
read -rp "Select a runner to download [1-4]: " CHOICE

case $CHOICE in
    1) 
        REPO="GloriousEggroll/proton-ge-custom"
        FILTER=".tar.gz" 
        ;;
    2) 
        REPO="Etaash-mathamsetty/Proton"
        FILTER=".tar.xz" # EA usually only has one main Linux asset
        ;;
    3) 
        REPO="CachyOS/proton-cachyos"
        FILTER="x86_64_v3.tar.xz" # Specifically target the optimized v3 build
        ;;
    *) echo "Exiting."; exit 0 ;;
esac

echo "--- Fetching latest release info for $REPO ---"

# Get the latest release download URL from GitHub API
REL_INFO=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Enhanced Filter: Finds the asset that matches our REPO-specific FILTER
DL_URL=$(echo "$REL_INFO" | grep "browser_download_url" | grep "$FILTER" | head -1 | cut -d '"' -f 4)

if [ -z "$DL_URL" ]; then
    echo "Error: Could not find a valid download URL matching '$FILTER' for $REPO."
    # Fallback for EA or GE if specific filter fails
    DL_URL=$(echo "$REL_INFO" | grep "browser_download_url" | grep -E ".tar.gz|.tar.xz" | head -1 | cut -d '"' -f 4)
    [ -z "$DL_URL" ] && exit 1
fi

FILE_NAME=$(basename "$DL_URL")
# Handles .tar.gz and .tar.xz for the directory name
DIR_NAME="${FILE_NAME%.tar.*}"

if [ -d "$RUNNERS_DIR/$DIR_NAME" ]; then
    echo "Latest runner ($DIR_NAME) is already installed."
    exit 0
fi

echo "Downloading: $FILE_NAME..."
curl -L "$DL_URL" -o "$RUNNERS_DIR/$FILE_NAME"

echo "Extracting to $RUNNERS_DIR..."
tar -xf "$RUNNERS_DIR/$FILE_NAME" -C "$RUNNERS_DIR"
rm "$RUNNERS_DIR/$FILE_NAME"

echo "--- Done! Update your global.conf PROTONPATH to: ---"
echo "$DIR_NAME"
