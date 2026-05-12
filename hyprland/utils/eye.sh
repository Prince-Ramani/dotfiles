#!/bin/bash
    
while true ; do
    sleep 1200
        notify-send \
            -a "Eye" \
            -i ~/.config/hypr/utils/icons/hidden.png \
            "Eye Break Reminder 👀" "Look away for 20 seconds at something far."
        mpg123 ~/.config/hypr/utils/tones/alert.mp3 > /dev/null 2>&1
done
