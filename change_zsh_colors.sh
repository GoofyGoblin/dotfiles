#!/bin/bash

source ~/.cache/wal/colors.sh
file_path="/home/winter/.config/ohmyposh/config.omp.toml"
variable_name="background"
new_value=$color1

sed -i "s/\(${variable_name} *= *\).*/\1\"${new_value}\"/" "$file_path"


