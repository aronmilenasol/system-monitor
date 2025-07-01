#!/bin/bash

TITLE="${2:-System Monitor}"
MESSAGE="$1"

notify-send "$TITLE" "$MESSAGE"
