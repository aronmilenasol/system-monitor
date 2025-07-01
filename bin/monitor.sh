#!/bin/bash

BASE_DIR="$(dirname "$(readlink -f "$0")")"
MODULES_DIR="$BASE_DIR/../modules"
LOG_DIR="$BASE_DIR/../logs"
MONITOR_LOG="$LOG_DIR/monitor.log"
NOTIFY="$BASE_DIR/../bin/notify.sh"


mkdir -p "$LOG_DIR"

"$NOTIFY" "System Monitor is running in the background at $(hostname)"

while true; do
  for module in "$MODULES_DIR"/*.sh; do
      if [ -x "$module" ]; then
          if ! "$module" 2>>"$MONITOR_LOG"; then
              TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
              echo "[$TIMESTAMP] Failed to run $module" >> "$MONITOR_LOG"
          fi
      fi
  done
  sleep 10
done
