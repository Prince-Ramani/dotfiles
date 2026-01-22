#!/bin/bash

while true; do
    battery_info=$(upower -i $(upower -e | grep battery))
    battery_percentage=$(echo "$battery_info" | grep -i percentage | awk '{print $2}' | sed 's/%//')
    state=$(echo "$battery_info" | grep -i state | awk '{print $2}')

    if [ "$battery_percentage" -lt 30 ] && [ "$state" != "charging" ]; then
        notify-send "Battery Warning" "Battery is at ${battery_percentage}%! Please plug in your charger."
        mpg123 ~/.config/hypr/utils/tones/alert.mp3
    fi

    sleep 300
done
