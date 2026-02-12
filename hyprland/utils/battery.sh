#!/bin/bash

while true; do
    battery_info=$(upower -i $(upower -e | grep battery))
    battery_percentage=$(echo "$battery_info" | grep -i percentage | awk '{print $2}' | sed 's/%//')
    state=$(echo "$battery_info" | grep -i state | awk '{print $2}')

    if [ "$battery_percentage" -lt 40 ] && [ "$state" != "charging" ]; then
        notify-send \
            -a "Battery" \
            -i /usr/share/icons/Papirus-Dark/48x48/status/battery-low-charging.svg \
            "Battery is at ${battery_percentage}%! Please plug in your charger."
        mpg123 ~/.config/hypr/utils/tones/alert.mp3
    fi


    if [ "$battery_percentage" -ge 80 ] && [ "$state" == "charging" ]; then
        notify-send \
            -a "Battery-Full" \
            "Battery is at ${battery_percentage}%! Please plug out your charger."
        mpg123 ~/.config/hypr/utils/tones/full.mp3
    fi

    sleep 300
done
