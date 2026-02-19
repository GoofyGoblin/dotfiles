#!/bin/bash

WALLPAPER_DIR="/home/winter/wallpapers"
SCRIPT=~/scripts/pywal16

RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) -print0 | shuf -n 1 -z)

if [ -z "$RANDOM_WALLPAPER" ]; then
  echo "No wallpapers found in $WALLPAPER_DIR. Please ensure image files (jpg, jpeg, png, gif) exist."
  exit 1
fi

wal -i "$RANDOM_WALLPAPER" -o $SCRIPT


