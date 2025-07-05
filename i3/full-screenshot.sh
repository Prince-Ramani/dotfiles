
mkdir -p ~/Pictures/Screenshots
FILENAME="full_screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
FILEPATH=~/Pictures/Screenshots/$FILENAME
scrot "$FILEPATH"
notify-send "📸 Fullscreen Screenshot Taken" "$FILENAME"
