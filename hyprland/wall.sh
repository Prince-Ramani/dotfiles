
#!/bin/bash

wallpapers=(/usr/share/backgrounds/archlinux/*)

len=${#wallpapers[@]}

ran=$((RANDOM % len))

random_wallpaper="${wallpapers[$ran]}"
filep="/home/prince/.config/hypr/hyprpaper.conf"
sed -i "s|preload = .*|preload = $random_wallpaper|" $filep
sed -i "s|wallpaper = .*|wallpaper = eDP-1, $random_wallpaper|" $filep

if pgrep -x "hyprpaper" > /dev/null
then
    pkill -x hyprpaper
    hyprpaper &
else
    hyprpaper &
fi

