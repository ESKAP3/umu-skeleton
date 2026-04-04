#!/bin/bash


TARGET_NAME="Cyberpunk"      #name of the game script without the .sh extension


# 1. Find the PID of the shell script
TARGET_PID=$(pgrep -f "bash.*$TARGET_NAME.*\.sh" | head -n 1)

if [ -z "$TARGET_PID" ]; then
    echo "[-] No running script found matching '$TARGET_NAME'."
    exit 1
fi

echo "[!] Found $TARGET_NAME (PID: $TARGET_PID)"
echo "[!] Sending SIGINT to process group..."

# Send signal to the negative pid (the whole group)
kill -INT -"$TARGET_PID" 2>/dev/null

# pipe all output to null and force a true exit status
wineserver -k >/dev/null 2>&1 || true

echo "[+] Shutdown signal sent."
