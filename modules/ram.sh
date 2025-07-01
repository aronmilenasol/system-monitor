#!/bin/bash

THRESHOLD=80
RAM_LOG_FILE="./logs/ram.log"
mkdir -p "$(dirname "$RAM_LOG_FILE")"

TOTAL_MEM=$(free -m | awk 'NR==2{print $2}')
USED_MEM=$(free -m | awk 'NR==2{print $3}')
USED_PERCENTAGE=$(echo "scale=2; ($USED_MEM / $TOTAL_MEM) * 100" | bc)
USED_INT=${USED_PERCENTAGE%.*}

if [ "$USED_INT" -ge "$THRESHOLD" ]; then
    TOP_PROCESSES=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 4 | tail -n 3)
    ALERT="[$(date '+%Y-%m-%d %H:%M:%S')] High RAM usage detected: ${USED_PERCENTAGE}%
    Top 3 processes:
    $TOP_PROCESSES"
    echo -e "$ALERT"
    echo -e "$ALERT\n" >> "$RAM_LOG_FILE"
    "$(dirname "$0")/../bin/notify.sh" "$ALERT" "High RAM Usage in $(hostname)"
fi
