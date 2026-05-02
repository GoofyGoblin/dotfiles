#!/bin/bash

 swayidle -w \
                timeout 300 'magick "$(cat ~/.cache/wal/wal)" -blur 0x6 -modulate 100,75 "/tmp/swaylock-bg.png" && swaylock -i /tmp/swaylock-bg.png' \
