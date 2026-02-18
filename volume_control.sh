#!/bin/bash

REPLACE_ID="9999" 
update_notification() {
    local message="$1"
    local icon="audio-volume-high" 

    MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$MUTE_STATUS" == "yes" ]; then
        icon="audio-volume-muted"
		muted="1"
    else
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
        if [ "$VOLUME" -eq 0 ]; then
            icon="audio-volume-off"
        elif [ "$VOLUME" -lt 50 ]; then 
            icon="audio-volume-low"
        else
            icon="audio-volume-high"
        fi
    fi

    
    
    dunstify -r "$REPLACE_ID" -u normal -h string:line:Volume -h string:icon:"$icon" "$message"
}


case "$1" in
    increase)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        # Re-evaluate MUTE_STATUS and VOLUME after changing volume
        MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [ "$MUTE_STATUS" == "yes" ]; then
            update_notification "Volume: Muted"
        else
            VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
            update_notification "Volume: ${VOLUME}%"
        fi
        ;;
    decrease)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        # Re-evaluate MUTE_STATUS and VOLUME after changing volume
        MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [ "$MUTE_STATUS" == "yes" ]; then
            update_notification "Volume: Muted"
        else
            VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
            update_notification "Volume: ${VOLUME}%"
        fi
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [ "$MUTE_STATUS" == "yes" ]; then
            update_notification "Volume: Muted"
        else
            VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
            update_notification "Volume: ${VOLUME}%"
        fi
        ;;
    *)
        echo "Usage: $0 {increase|decrease|mute}"
        exit 1
        ;;
esac

