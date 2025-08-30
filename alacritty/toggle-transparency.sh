#!/bin/bash

CONFIG="$HOME/.config/alacritty/alacritty.toml"

if [ ! -f "$CONFIG" ]; then
  echo "Alacritty config not found at $CONFIG"
  exit 1
fi

current_opacity=$(grep -E '^opacity\s*=' "$CONFIG" | awk -F= '{gsub(/[[:space:]]/, "", $2); print $2}')

if [ -z "$current_opacity" ]; then
  echo "No background_opacity setting found. Adding it with default opaque value."
  echo -e "\nopacity = 1.0" >> "$CONFIG"
  current_opacity="1.0"
fi

if [[ "$current_opacity" == "1.0" ]]; then
  new_opacity="0.90"
else
  new_opacity="1.0"
fi

sed -i "s/^opacity\s*=.*/opacity = $new_opacity/" "$CONFIG"

