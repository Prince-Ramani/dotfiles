#!/bin/bash

STEP=5
MAX=100
ICON_DIR="$HOME/.config/hypr/utils/icons"

case "$1" in
  up)
    pamixer -i $STEP
    ;;
  down)
    pamixer -d $STEP
    ;;
  mute)
    pamixer -t
    ;;
esac

VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$VOLUME" -gt "$MAX" ]; then
  pamixer --set-volume $MAX
  VOLUME=$MAX
fi

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="$ICON_DIR/volume-muted.png"
  TEXT="Muted"
  BAR=0
else
  if [ "$VOLUME" -lt 30 ]; then
    ICON="$ICON_DIR/volume-low.png"
  elif [ "$VOLUME" -lt 70 ]; then
    ICON="$ICON_DIR/volume-medium.png"
  else
    ICON="$ICON_DIR/volume-high.png"
  fi

  TEXT="Volume ${VOLUME}%"
  BAR=$VOLUME
fi

canberra-gtk-play -i audio-volume-change -d "volume" &

# Notify mako
notify-send \
  -a "Volume" \
  -u low \
  -h string:x-canonical-private-synchronous:volume \
  -h int:value:$BAR \
  -i "$ICON" \
  "$TEXT"
