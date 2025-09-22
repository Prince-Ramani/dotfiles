#!/bin/bash

SAVE_DIR="$HOME/Pictures/Screenshots"

FILENAME="screenshot_$(date +%s)_$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6).png"

grim "$SAVE_DIR/$FILENAME"
notify-send -t 5000 "📷 Screenshot Taken!" "Screenshot saved as $SAVE_DIR/$FILENAME"
mpg123 /home/prince/audio/notifications/click.mp3
