#!/bin/bash

wallpapers=(~/Pictures/walls/*)

len=${#wallpapers[@]}
ran=$((RANDOM % len))
random_wallpaper="${wallpapers[$ran]}"

filep="$HOME/.config/hypr/hyprpaper.conf"

cat > "$filep" <<EOF
splash = false
wallpaper {
    monitor=eDP-1
    path = $random_wallpaper
    fit_mode = cover
}
EOF

if pgrep -x "hyprpaper" > /dev/null; then
    pkill -x hyprpaper
fi
hyprpaper &
