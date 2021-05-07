#!/bin/bash

# kde
echo "exec startkde" > /home/$USER/.xinitrc
sudo pacman -S plasma-{browser-integration,desktop,disks,firewall,systemmonitor,workspace{,-wallpapers},pa,nm} breeze-gtk kde{-gtk-config,plasma-addons} k{screen,win,writed} sddm sddm-kcm
sudo pacman -S kdialog khelpcenter khotkeys user-manager xdg-desktop-portal-kde kdegraphics-thumbnailers 
# plasma5-applets-redshift-control

echo "[General]
Numlock=on

[Theme]
# Current theme name
Current=breeze

# Cursor theme used in the greeter
CursorTheme=breeze_cursors" >> /etc/sddm.conf

sudo systemctl enable sddm

echo "[KDE]
SingleClick=false" >> ~/.config/kdeglobals

# applications
sudo pacman -S ark dolphin dolphin-plugins filelight gwenview kwrite k{calc,deconnect,floppy,runner,onsole} partitionmanager python-nautilus okular spectacle transmission-qt

echo "Kde plasma is installed!"
echo "Reboot your system"
