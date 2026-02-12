#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/walls"  
CACHE_DIR="$HOME/.cache/wallpaper-selector"
THUMBNAIL_WIDTH="320"  
THUMBNAIL_HEIGHT="180"
mkdir -p "$CACHE_DIR"

generate_thumbnail() {
    local input="$1"
    local output="$2"
    magick "$input" -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" -gravity center -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" "$output"
}


generate_menu() {
    
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue
        
        thumbnail="$CACHE_DIR/$(basename "${img%.*}").png"
        
        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            generate_thumbnail "$img" "$thumbnail"
        fi
        
        echo -en "img:$thumbnail\x00info:$(basename "$img")\x1f$img\n"
    done
}

selected=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 4 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf ~/.config/wofi/wallpaper.conf \
  )

if [ -n "$selected" ]; then
    thumbnail_path="${selected#img:}"

        original_filename=$(basename "${thumbnail_path%.*}")

        original_path=$(find "$WALLPAPER_DIR" -type f -name "${original_filename}.*" | head -n1)

    if [ -n "$original_path" ]; then
        echo $original_path
        /home/username/.config/hypr/utils/wall.sh "$original_path"


        notify-send "Wallpaper" "Wallpaper has been updated" -i "$original_path"
    else
        notify-send "Wallpaper Error" "Could not find the original wallpaper file."
    fi
fi
