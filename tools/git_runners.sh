#!/bin/bash

# Setup paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUNNERS_DIR="$(dirname "$SCRIPT_DIR")/runners"
mkdir -p "$RUNNERS_DIR"

echo "--- Runner Downloader ---"
echo "1) GE-Proton (GloriousEggroll)"
echo "2) Proton-EM (Etaash-mathamsetty)"
echo "3) Proton-CachyOS (Auto-detecting x86_64 level)"
echo "4) Exit"
read -rp "Select a runner to download [1-4]: " CHOICE

case $CHOICE in
    1) 
        REPO="GloriousEggroll/proton-ge-custom"
        FILTER=".tar.gz" 
        ;;
    2) 
        REPO="Etaash-mathamsetty/Proton"
        FILTER=".tar.xz" 
        ;;
    3) 
        REPO="CachyOS/proton-cachyos"
        # Find the loader path dynamically to be distro-agnostic
        LOADER=$(/sbin/ldconfig -p | grep -m1 "ld-linux-x86-64.so.2" | awk '{print $NF}')
        
        # Check supported levels (v4 > v3 > fallback)
        if "$LOADER" --help | grep -q "x86-64-v4 (supported"; then
            V_LEVEL="v4"
        elif "$LOADER" --help | grep -q "x86-64-v3 (supported"; then
            V_LEVEL="v3"
        else
            V_LEVEL=""
        fi

        # Construct the filter
        if [ -n "$V_LEVEL" ]; then
            FILTER="slr-x86_64_$V_LEVEL.tar.xz"
            echo "Detecting hardware... $V_LEVEL supported."
        else
            FILTER="slr-x86_64.tar.xz" # Generic fallback if no v3/v4 detected
            echo "Detecting hardware... No v3/v4 found, falling back to generic version."
        fi
        ;;
    *) echo "Exiting."; exit 0 ;;
esac

echo "--- Fetching latest release info for $REPO ---"

# Get the latest release download URL from GitHub API
REL_INFO=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Filter
DL_URL=$(echo "$REL_INFO" | grep "browser_download_url" | grep "$FILTER" | head -1 | cut -d '"' -f 4)

if [ -z "$DL_URL" ]; then
    echo "Error: Could not find a valid download URL matching '$FILTER' for $REPO."
    # Fallback to general archive if the specific filter fails
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
