#!/bin/bash
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
pipewire &

exec dbus-run-session sway
# exec swaymsg output eDP-1 transform 90 clockwise
