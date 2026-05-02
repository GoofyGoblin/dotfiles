#!/bin/bash

# Options shown in rofi
options=" Lock
 Shutdown
 Reboot
 Suspend
 Exit"

choice=$(echo "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
  " Lock")
    bg=/tmp/swaylock-bg.png
    magick "$(cat ~/.cache/wal/wal)" -blur 0x6 -modulate 100,75 "/tmp/swaylock-bg.png"
    swaylock -i "$bg"
    ;;
  " Shutdown")
    doas poweroff
    ;;
  " Reboot")
    doas reboot
    ;;
  " Suspend")
    bg=/tmp/swaylock-bg.png
    magick "$(cat ~/.cache/wal/wal)" -blur 0x6 -modulate 100,75 "/tmp/swaylock-bg.png"
    swaylock -i "$bg"
    ;;
  " Exit")
    swaymsg exit
    ;;
  *)
    exit 0
    ;;
esac
