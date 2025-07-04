#!/bin/bash

TITLE="${2:-System Monitor}"
MESSAGE="$1"

# Detect if there's a graphical environment
if command -v notify-send >/dev/null 2>&1; then
    notify-send "$TITLE" "$MESSAGE"
else
    LOG_PATH="./logs/monitor.log"
    mkdir -p "$(dirname "$LOG_PATH")"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $TITLE - $MESSAGE" >> "$LOG_PATH"
fi