#!/bin/bash
WALLPAPER_DIR="/home/winter/wallpapers"

RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0 | shuf -n 1 -z)

if [ -z "$RANDOM_WALLPAPER" ]; then
  echo "No wallpapers found in $WALLPAPER_DIR."
  exit 1
fi

# Run wal and pywal16 sequentially so files are written before reloading waybar/swaybg
wal -i "$RANDOM_WALLPAPER"
./pywal16

# Kill existing swaybg if running
if pid="$(pidof swaybg)"; then
  kill "$pid"
fi

# Start swaybg with the chosen wallpaper in background (nohup is POSIX-friendly)
nohup swaybg -i "$RANDOM_WALLPAPER" >/dev/null 2>&1 &
