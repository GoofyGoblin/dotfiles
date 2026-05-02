#!/bin/bash

# wal -i "$CHOICE" -o "pywal16"
FOLDER=~/wallpapers

# (
#   sleep 0.15                                  # give nsxiv a moment to create window
#   # find newest nsxiv window (by WM_CLASS "nsxiv")
#   wid=""
#   for i in {1..20}; do
#     wid=$(xdotool search --class nsxiv | tail -n1)
#     [ -n "$wid" ] && break
#     sleep 0.05
#   done
#
#   if [ -n "$wid" ]; then
#     # activate window (optional) then send the toggle-floating keybinding
#     xdotool windowactivate "$wid"
#     xdotool key --window "$wid" Super+Shift+space
#   fi
# ) &

CHOICE=$(nsxiv -otb $FOLDER/*)

if [ -n "$CHOICE" ]; then
  swaybg -i "$CHOICE" 
  echo "$CHOICE"
else
  echo "No wallpaper selected"
fi
