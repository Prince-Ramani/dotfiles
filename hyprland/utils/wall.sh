#!/bin/bash

WALL_DIR="$HOME/Pictures/walls"
FILEP="$HOME/.config/hypr/hyprpaper.conf"

if [[ -n "$1" ]]; then
    random_wallpaper="$1"
else
    wallpapers=("$WALL_DIR"/*)
    len=${#wallpapers[@]}
    ran=$((RANDOM % len))
    random_wallpaper="${wallpapers[$ran]}"
fi

if [[ ! -f "$random_wallpaper" ]]; then
    echo "Wallpaper not found: $random_wallpaper"
    exit 1
fi

cat > "$FILEP" <<EOF
splash = false
wallpaper {
    monitor = eDP-1
    path = $random_wallpaper
    fit_mode = cover
}
EOF

if pgrep -x hyprpaper > /dev/null; then
    pkill -x hyprpaper
fi

hyprpaper &
