#!/bin/bash

THRESHOLD=80
CPU_LOG_FILE="./logs/cpu.log"
mkdir -p "$(dirname "$CPU_LOG_FILE")"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

CPU_USAGE=$(top -bn1 | grep -E "^%?Cpu" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -ge "$THRESHOLD" ]; then
  TOP_PROCESSES=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 4 | tail -n 3)

  ALERT="[$TIMESTAMP] High CPU detected: ${CPU_INT}% 
Top 3 processes:
$TOP_PROCESSES"

  echo -e "$ALERT"
  echo -e "$ALERT\n" >> "$CPU_LOG_FILE"
  ./notify.sh "$ALERT"
fi
