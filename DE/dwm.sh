#!/bin/bash

sudo pacman -S nitrogen redshift rofi xorg-xinit libx11 libxinerama libxft webkit2gtk

cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo "Remove the last lines"
read -n 1 -s -r -p "...Press any key to continue... "
nano ~/.xinitrc

# Keyboard layout
echo "setxkbmap latam &" >> ~/.xinitrc
# Display Resolution
echo "xrandr --output HDMI-0 --mode 1600x900 &" >> ~/.xinitrc
# Redshift
echo "redshift -l 71:-10 -t 3600:3600 &" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc

mkdir -p ~/.config/dwm

git clone git://git.suckless.org/st ~/.config/dwm/st
git clone git://git.suckless.org/dwm ~/.config/dwm/dwm

cd ~/.config/dwm/st
make clean
make
sudo make install

cd ~/.config/dwm/dwm
make clean
make
sudo make install

cd ~
mkdir Desktop Documents Downloads Pictures Videos
