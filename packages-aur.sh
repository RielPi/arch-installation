#!/bin/bash

# install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# paru config
echo "uncomment #BottomUp and add SkipReview bellow it"
read -n 1 -s -r -p "...Press any key to continue... "
sudo nano /etc/paru.conf

# key required for spotify (official site), it won't install without it
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
paru -S bitwarden fluent-reader hardcode-tray pfetch simple-mtpfs spotify obsidian-appimage minecraft-launcher
paru -S libxft-bgra lib32-libxft-bgra
# required by cryptomator
#paru -S jdk jdk-adoptopenjdk davfs2 kio-fuse sshfs
#paru -S cryptomator
