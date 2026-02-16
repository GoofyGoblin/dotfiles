#!/bin/bash

# Toggle mute
pactl set-sink-mute @DEFAULT_SINK@ toggle

# Get mute status and current volume level
MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

if [ "$MUTE_STATUS" == "yes" ]; then
    dunstify -u normal "Volume" "Muted"
else
    dunstify -u normal "Volume" "Unmuted, current volume at ${VOLUME}%"
fi

