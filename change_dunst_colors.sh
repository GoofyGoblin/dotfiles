#!/bin/bash

source ~/.cache/wal/colors.sh

cat > ~/.config/dunst/dunstrc.tmp << EOF
[global]
    geometry = "300x100-10+10"
	foreground = "$color7"
	background = "$color0"
	border = "$color1"
	font = "JetBrainsMonoNL 12"
# You can add more Dunst-specific configurations here using the imported colors
EOF

mv ~/.config/dunst/dunstrc.tmp ~/.config/dunst/dunstrc

pkill dunst
dunst &
