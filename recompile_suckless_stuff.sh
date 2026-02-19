#!/bin/bash

cd ~/suckless_stuff/st
rm -rf config.h
doas make clean install

cd ~/suckless_stuff/dwm
rm -rf config.h
doas make clean install

