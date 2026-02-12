#!/bin/bash

STEP=5
MIN=1

CURRENT=$(brightnessctl g)
MAX=$(brightnessctl m)
PERCENT=$(( CURRENT * 100 / MAX ))
ICON="$HOME/.config/hypr/utils/icons/brightness-full.png"


case "$1" in
  up)
    if [ "$PERCENT" -le "$MIN" ]; then
    brightnessctl set 5%
    else
    brightnessctl set +${STEP}%
    fi
    ;;
  down)
    if [ "$PERCENT" -le 5 ]; then
      brightnessctl set 1%
    else
      brightnessctl set 5%-
    fi
    ;;
esac

NEW=$(brightnessctl g)
NEW_PERCENT=$(( NEW * 100 / MAX ))

canberra-gtk-play -i message-new-instant -d "volume" &


notify-send \
  -a "Brightness" \
  -u low \
  -h string:x-canonical-private-synchronous:brightness \
  -h int:value:${NEW_PERCENT} \
  -i "$ICON" \
  "Brightness: ${NEW_PERCENT}%"
