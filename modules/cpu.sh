#!/bin/bash

THRESHOLD=80
CPU_LOG_FILE="./logs/cpu.log"
mkdir -p "$(dirname "$CPU_LOG_FILE")"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

CPU_USAGE=$(top -bn1 | grep -E "^%?Cpu" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -ge "$THRESHOLD" ]; then
    TOP_PROCESSES=$(ps -eo pid,comm,%cpu --sort=-%cpu | sed 1d | grep -vE "(ps|cpu\.sh|monitor\.sh|grep)" | head -n 3)
    
    ALERT="[$TIMESTAMP] High CPU detected: ${CPU_INT}%\nTop 3 processes:\n$TOP_PROCESSES"
    
    echo -e "$ALERT"
    echo -e "$ALERT\n" >> "$CPU_LOG_FILE"
    "$(dirname "$0")/../bin/notify.sh" "$ALERT" "High CPU Usage in $(hostname)"
fi
