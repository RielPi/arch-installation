#!/bin/bash

read -p "Did you modify the last line of the script? (y/n): " option
if [ $option == n ]; then
  lsblk
  echo "Add root partition to /dev/sdX3 (last line) and run again the script."
  exit
else 
  echo "Continue"
fi

# [1] timezone
echo "[1] Setting timezone (America/Bogota)"
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

# [2] language
echo "[2] Editing locale.gen, find en_US.UTF-8 & en_US ISO-8859-1, and uncomment"
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
echo "
[multilib]
Include = /etc/pacman.d/mirrorlist

# AUR
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

pacman -Sy

# [8] Install packages
pacman -S linux linux-headers networkmanager intel-ucode

mkinitcpio -p linux
systemctl enable NetworkManager.service

# [9] bootctl
bootctl install

echo "title Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

# [10] systemd-boot hook, DO NOT REMOVE (archwiki for more info)
mkdir /etc/pacman.d/hooks
echo "[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update" >> /etc/pacman.d/hooks/systemd-boot.hook

# [11] Nvidia Drivers
pacman -S xorg xorg-apps xorg-init xorg-server xorg-server-devel
pacman -S nvidia nvidia-{utils,libgl,settings} lib32-nvidia-{utils,libgl} vulkan-icd-loader lib32-vulkan-icd-loader

# nvidia hook, DO NOT REMOVE (archwiki for more info)
echo "[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'" >> /etc/pacman.d/hooks/nvidia.hook

# Reduce swappiness
echo "vm.swappiness=10" >> /etc/sysctl.d/99-sysctl.conf

# edit bellow line
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sdX3) rw" >> /boot/loader/entries/arch.conf
# edit above line
echo "Installation was completed!"
