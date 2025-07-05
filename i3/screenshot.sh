
mkdir -p ~/Pictures/Screenshots

sleep 0.3
FILENAME="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

scrot -s  ~/Pictures/Screenshots/$FILENAME
notify-send "✅ Screenshot taken" "$FILENAME"
