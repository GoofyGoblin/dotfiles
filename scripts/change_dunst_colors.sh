#!/usr/bin/env bash

source ~/.cache/wal/colors.sh

cat > ~/dotfiles/.config/dunst/dunstrc.tmp << EOF
[global]
    geometry = "300x100-10+10"
	foreground = "$color7"
	background = "$color0"
	border = "$color1"
	font = "JetBrainsMonoNL 12"
    follow = "mouse"
# You can add more Dunst-specific configurations here using the imported colors
EOF

mv ~/dotfiles/.config/dunst/dunstrc.tmp ~/dotfiles/.config/dunst/dunstrc
