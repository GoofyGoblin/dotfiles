#!/bin/bash

DISK="/dev/sda"
HOSTNAME="void-minimal"
USERNAME="winter"
DOTFILES_REPO="https://github.com/GoofyGoblin/dotfiles.git"
SUCKLESS_STUFF="https://github.com/GoofyGobin/suckless_stuff.git"

RAM_MB=$(free -m | awk '/^Mem:/{print $2}')
SWAP_SIZE_MB=$((RAM_MB * 2))
echo "Memory detected: ${RAM_MB}MB. Creating ${SWAP_SIZE_MB}MB swap."

echo "Partitioning $DISK..."
wipefs -a "$DISK"
sfdisk "$DISK" <<EOF
label: gpt
device: $DISK
unit: sectors

size=1048576, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
size=${SWAP_SIZE_MB}M, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

if [[ $DISK == *"nvme"* ]]; then P="${DISK}p"; else P="${DISK}"; fi

mkfs.vfat "${P}1"
mkswap "${P}2"
swapon "${P}2"
mkfs.ext4 "${P}3"

mount "${P}3" /mnt
mkdir -p /mnt/boot/efi
mount "${P}1" /mnt/boot/efi

echo "Installing base-container and essential packages..."
export REPO=https://repo-default.voidlinux.org/current
XBPS_ARCH=x86_64 xbps-install -S -R "$REPO" -r /mnt \
    base-container linux grub-x86_64-efi efibootmgr \
    dhcpcd git nvim bash-completion

cp /etc/resolv.conf /mnt/etc/
mount -t proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev

chroot /mnt /bin/bash <<EOF
# Set Hostname
echo "$HOSTNAME" > /etc/hostname

# Generate fstab
cat <<FSTAB > /etc/fstab
${P}3  /       ext4    defaults              1 1
${P}1  /boot/efi vfat    defaults              0 2
${P}2  none    swap    sw                    0 0
FSTAB

# Configure Grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"
update-grub

# User Setup
useradd -m -s /bin/bash -G wheel,audio,video,storage $USERNAME
echo "Root password:"
passwd
echo "User password for $USERNAME:"
passwd $USERNAME

# Dotfiles
echo "Cloning dotfiles..."
sudo -u $USERNAME git clone "$DOTFILES_REPO" "/home/$USERNAME/dotfiles && git clone "$SUCKLESS_REPO" /home/$USERNAME/suckless_stuff"

# Enable Network
ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default/
EOF

# --- 6. Cleanup ---
umount -R /mnt
echo "Installation complete. Remove ISO and reboot.""
