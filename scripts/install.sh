#!/bin/bash

# Script to install official packages and AUR packages after archinstall
# Requires running as a regular user with sudo privileges

# --- Configuration ---
OFFICIAL_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"
AUR_HELPER="paru" # You can change this to paru if you prefer

# Check for root privileges (this script should run as a standard user)
if [ "$EUID" -eq 0 ]; then
    echo "Please run this script using your standard user account (not root)."
    exit
fi

# 1. Install packages from the official repositories
echo "Starting installation of packages from official repositories..."
# Use --needed to skip packages that are already part of the base install
sudo pacman -Syu --needed --noconfirm $(<"$OFFICIAL_LIST")

if [ $? -eq 0 ]; then
    echo "Official package installation complete."
else
    echo "An error occurred during official package installation. Please check the output."
    exit 1
fi

# 2. Install the AUR helper (e.g., yay)
echo "Installing the AUR helper ($AUR_HELPER)..."
sudo pacman -S --needed --noconfirm base-devel git
git clone "aur.archlinux.org" /tmp/"$AUR_HELPER"
cd /tmp/"$AUR_HELPER"
makepkg -si --noconfirm
cd ~
rm -rf /tmp/"$AUR_HELPER"

# 3. Install AUR packages using the helper
if [ -s "$AUR_LIST" ]; then
    echo "Starting installation of AUR packages..."
    # This command uses the newly installed helper to install the packages in the list
    "$AUR_HELPER" -S --needed --noconfirm $(<"$AUR_LIST")

    if [ $? -eq 0 ]; then
        echo "AUR package installation complete."
    else
        echo "An error occurred during AUR package installation. Please check the output."
    fi
else
    echo "No AUR packages found to install ($AUR_LIST is empty or non-existent)."
fi

echo "Installation process finished!"
