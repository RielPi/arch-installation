#!/bin/bash

# kde
echo "exec startkde" > /home/$USER/.xinitrc
sudo pacman -S plasma-{browser-integration,desktop,disks,firewall,systemmonitor,workspace{,-wallpapers},pa,nm} breeze-gtk kde{-gtk-config,plasma-addons} k{screen,win,writed} sddm sddm-kcm
sudo pacman -S kdialog khelpcenter khotkeys xdg-desktop-portal-kde kdegraphics-thumbnailers powerdevil
# plasma5-applets-redshift-control

sudo systemctl enable sddm

echo "[KDE]
SingleClick=false" >> ~/.config/kdeglobals

# applications
sudo pacman -S ark dolphin dolphin-plugins filelight gwenview kwrite k{calc,deconnect,floppy,runner,onsole} partitionmanager python-nautilus okular spectacle transmission-qt

# plank good, latte bad
sudo pacman -S plank

echo " Add the following config in /etc/sddm.conf
[General]
Numlock=on

[Theme]
# Current theme name
Current=breeze

# Cursor theme used in the greeter
CursorTheme=breeze_cursors"
echo "------------------------"
echo "Kde plasma is installed!"
echo "Reboot your system"
