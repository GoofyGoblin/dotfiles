#!/bin/bash

FOLDER=~/wallpapers
CHOICE=$(nsxiv -otb $FOLDER/*)

wal -i "$CHOICE" -o "pywal16"

