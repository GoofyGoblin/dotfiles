#!/bin/bash

# Notification identifier
NOTIFY_ID="volume-notification"

# Current volume level
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

# Function to update the notification
update_notification() {
    dunstify -u normal -r $NOTIFY_ID "Volume" "$1" --icon=audio-volume-high
}

# Get the operation (increase, decrease, mute)
case "$1" in
    increase)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
        update_notification "Increased to ${VOLUME}%"
        ;;
    decrease)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
        update_notification "Decreased to ${VOLUME}%"
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [ "$MUTE_STATUS" == "yes" ]; then
            update_notification "Muted"
        else
            VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
            update_notification "Unmuted, current volume at ${VOLUME}%"
        fi
        ;;
    *)
        echo "Usage: $0 {increase|decrease|mute}"
        exit 1
        ;;
esac
