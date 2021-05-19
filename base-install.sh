#!/bin/bash

# [1] timezone
echo "[1] Setting timezone (America/Bogota)"
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

# [2] language
echo "[2] Editing locale.gen, find en_US.UTF-8 & en_US ISO-8859-1, ja_JP.UTF-8 UTF-8 and uncomment"
read -n 1 -s -r -p "...Press any key to continue... "
nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf

# [3] hostname
read -p "[3] Insert hostname: " hostname
echo $hostname >> /etc/hostname

# [4] password for root
echo "[4] Insert password for root"
passwd

# [5] create user
echo "[5] Create user"
read -p "...Insert username: " user
read -p "...Insert name: " name
useradd -m -g users -G wheel,storage,power -s /bin/bash $user -c $name
passwd $user

# [6] uncheck %wheel ALL=(ALL) ALL
echo "[6] Editing /etc/sudoers, uncomment %wheel ALL=(ALL) ALL"
read -n 1 -s -r -p "...Press any key to continue... "
nano /etc/sudoers

# [7] Enable multilib & AUR
cat configs/pacman.conf >> /etc/pacman.conf
pacman -Sy

# [8] Install packages
pacman -S linux linux-headers man-db networkmanager intel-ucode

mkinitcpio -p linux
systemctl enable NetworkManager.service

# [9] bootctl
bootctl install

echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

rootpartition=$(df / | grep -Eo '/dev/[^ ]+')
lsblk
echo ""
echo "Make sure this is correct, otherwise you'll have trouble booting your system"
read -p "Is \"$rootpartition\" your (/) root partition? (y/n): " option

if [[ $option == y ]]; then
    echo "options root=PARTUUID=$(blkid -s PARTUUID -o value $rootpartition) rw nvidia-drm.modeset=1" >> /boot/loader/entries/arch.conf
elif [[ $option == n ]]; then
    read -p "Insert the name of your root partition (/dev/sda3, /dev/sdb3): " new
    echo "options root=PARTUUID=$(blkid -s PARTUUID -o value $new) rw nvidia-drm.modeset=1" >> /boot/loader/entries/arch.conf
fi

# [10] Nvidia Drivers
pacman -S xorg xorg-apps
pacman -S nvidia nvidia-{utils,libgl,settings} lib32-nvidia-{utils,libgl} vulkan-icd-loader lib32-vulkan-icd-loader

# [11] Hooks
mkdir /etc/pacman.d/hooks
# systemd-boot hook, DO NOT REMOVE (archwiki for more info)
cp hooks/systemd-boot.hook /etc/pacman.d/hooks/systemd-boot.hook
# nvidia hook, DO NOT REMOVE (archwiki for more info)
cp hooks/nvidia.hook /etc/pacman.d/hooks/nvidia.hook

# Reduce swappiness
echo "vm.swappiness=10" >> /etc/sysctl.d/99-sysctl.conf

echo "Installation was completed!"
