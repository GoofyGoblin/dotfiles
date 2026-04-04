#!/bin/bash

FOLDER=~/wallpapers
CHOICE=$(nsxiv -otb $FOLDER/* & echo $! )   # start nsxiv in background and keep PID
sleep 0.15                                  # give nsxiv a moment to create window

# find newest nsxiv window (by WM_CLASS "nsxiv")
wid=""
for i in {1..20}; do
  wid=$(xdotool search --class nsxiv | tail -n1)
  [ -n "$wid" ] && break
  sleep 0.05
done

if [ -n "$wid" ]; then
  # activate window (optional) then send the toggle-floating keybinding
  xdotool windowactivate "$wid"
  xdotool key --window "$wid" Super+Shift+space
else
  echo "nsxiv window not found" >&2
fi

wal -i "$CHOICE" -o "pywal16"
