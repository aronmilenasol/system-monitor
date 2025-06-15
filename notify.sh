#!/bin/bash

ALERT="$1"

notify-send "High CPU Usage in $(hostname)" "$ALERT"