#!/bin/bash

# Increase volume by 5%
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Get the new volume level
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

# Show notification with progress bar
dunstify -u normal "Volume" "Increased to ${VOLUME}%" --replace=volume-notification

