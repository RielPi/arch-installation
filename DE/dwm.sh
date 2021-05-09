#!/bin/bash

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

sudo pacman -S nitrogen redshift xorg-xinit libx11 libxinerama libxft webkit2gtk

mkdir -p ~/.local/src

git clone git://git.suckless.org/st ~/.local/src/st
git clone git://git.suckless.org/dwm ~/.local/src/dwm
git clone git://git.suckless.org/dmenu ~/.local/src/dmenu


cd ~/.local/src/st
make clean
make
sudo make install

cd ~/.local/src/dwm
make clean
make
sudo make install

cd ~/.local/src/dmenu
make clean
make
sudo make install

cd ~
mkdir Desktop Documents Downloads Pictures Videos
