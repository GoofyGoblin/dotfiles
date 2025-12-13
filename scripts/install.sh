#!/bin/bash

# --- Configuration Variables ---
USERNAME="your_username" # Change this to your desired username
DOTFILES_REPO="github.com"
PKG_LIST_URL="URL_TO_YOUR_PKG_LIST/pkglist.txt" # e.g., Raw link from GitHub Gist or URL

# Safety check for running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo "Starting custom Arch system configuration..."

# 1. Update system time
hwclock --systohc

# 2. Configure Locale and Timezone (Adjust if necessary)
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# 3. Configure Networking (Set a hostname)
echo "myhostname" >/etc/hostname

# 4. Create User and Set Password (You will be prompted for passwords later)
useradd -mG wheel,storage,video "$USERNAME"
echo "Set root password:"
passwd
echo "Set $USERNAME password:"
passwd "$USERNAME"

# 5. Install Sudo
pacman -Syu --noconfirm sudo git base-devel
# Ensure the wheel group can use sudo
EDITOR=tee visudo <<EOF
%wheel ALL=(ALL) ALL
EOF

# 6. Install All Required Packages

echo "Downloading package list..."
curl -O "$PKG_LIST_URL"

echo "Installing all packages from pkglist.txt..."
# Use --needed to only install packages not already present in the base system
pacman -Syu --needed --noconfirm - <pkglist.txt

# 7. Setup Bootloader (Example using GRUB for EFI systems)
# Make sure you mounted your EFI partition correctly (e.g., at /boot/efi or /boot)
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ArchLinux
grub-mkconfig -o /boot/grub/grub.cfg

# 8. Deploy Dotfiles (Switches to the user context)
echo "Deploying dotfiles for $USERNAME..."
su - "$USERNAME" -c "
    cd ~
    git clone $DOTFILES_REPO .config/mydotfiles # Clones into a subdirectory
    # If your repo contains files for ~, you need a method to symlink/copy them.
    # A common approach is a 'stow' or 'chezmoi' setup script within the repo itself.
    # Example using Chezmoi:
    # sh -c '$(curl -fsSL git.io)' -- init --apply yourusername
"

echo "Installation script finished. Run 'exit' to leave chroot, then 'reboot'."
