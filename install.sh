#!/bin/bash

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
echo "[5] Create user
read -p "...Insert username: " user
read -p "...Insert fullname: " fullname
useradd -m -g users -G wheel,storage,power -s /bin/bash $user -c $fullname
passwd $user

# [6] uncheck %wheel ALL=(ALL) ALL
echo "[6] Editing /etc/sudoers, uncomment %wheel ALL=(ALL) ALL"
read -n 1 -s -r -p "...Press any key to continue... "
nano /etc/sudoers

# [7] Enable multilib
echo "[7] Editing pacman.conf, uncomment multilib repo"
read -n 1 -s -r -p "...Press any key to continue... "
nano /etc/pacman.conf
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
echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/sdX3) rw" >> /boot/loader/entries/arch.conf
