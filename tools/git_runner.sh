#!/bin/bash

# Setup paths based on your skeleton structure
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUNNERS_DIR="$(dirname "$SCRIPT_DIR")/runners"
mkdir -p "$RUNNERS_DIR"

echo "--- Fetching latest GE-Proton Release Info ---"

# Get the latest release download URL from GitHub API
REL_INFO=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest)
DL_URL=$(echo "$REL_INFO" | grep "browser_download_url" | grep ".tar.gz" | head -1 | cut -d '"' -f 4)
FILE_NAME=$(basename "$DL_URL")
DIR_NAME="${FILE_NAME%.tar.gz}"

if [ -d "$RUNNERS_DIR/$DIR_NAME" ]; then
    echo "Latest runner ($DIR_NAME) is already installed."
    exit 0
fi

echo "Downloading: $FILE_NAME..."
curl -L "$DL_URL" -o "$RUNNERS_DIR/$FILE_NAME"

echo "Extracting to $RUNNERS_DIR..."
tar -xzf "$RUNNERS_DIR/$FILE_NAME" -C "$RUNNERS_DIR"
rm "$RUNNERS_DIR/$FILE_NAME"

echo "--- Done! Update your global.conf PROTONPATH to: ---"
echo "$DIR_NAME"
