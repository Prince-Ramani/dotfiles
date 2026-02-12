#!/usr/bin/env bash

CONF="$HOME/.config/hypr/animations.conf"

if grep -q "\$ANIM = true" "$CONF"; then
    sed -i \
        -e 's/\$ANIM = true/\$ANIM = false/' \
        -e 's/\$OPACITY = 0.92/\$OPACITY = 1.0/' \
        -e 's/\(windowrule = match:class Alacritty, opacity \$OPACITY\)/\1 border_size 0/' \
        "$CONF"

    pkill hyprpaper

    notify-send -h string:x-canonical-private-synchronous:zenmode \
        "Zen Mode" "Focus mode enabled 🧘"
else
    sed -i \
        -e 's/\$ANIM = false/\$ANIM = true/' \
        -e 's/\$OPACITY = 1.0/\$OPACITY = 0.92/' \
        -e 's/ border_size 0//' \
        "$CONF"

    hyprctl dispatch exec hyprpaper

    notify-send -h string:x-canonical-private-synchronous:zenmode \
        "Chill Mode" "Enjoy ✨"
fi

hyprctl reload
