#!/bin/bash

file_path="/home/winter/suckless_stuff/dwm/config.def.h"
variable_name="showsystray"
new_value="0"

cd ~/suckless_stuff/dwm
sed -i "s/\(${variable_name} *= *\).*/\1${new_value};/" "$file_path"

cd ~/suckless_stuff/dwm
rm -rf config.h
doas make clean install
kill -HUP $(pidof dwm)

notify-send "systray disabled"
