#!/bin/bash
sudo pacman -Syu

# "essenstials"
sudo pacman -S curl htop hunspell{-es_any,-en_US} gnupg screenfetch ufw wget zsh zsh-completions
# fonts
sudo pacman -S noto-fonts-emoji ttf-{hack,anonymous-pro,dejavu,freefont,liberation,roboto,bitstream-vera,croscore,droid,ubuntu-font-family} lib32-fontconfig wqy-zenhei
#yay -S ttf-{ms-fonts,monaco,emojione-color,twemoji-color}

# ufw
sudo enable ufw
sudo systemctl enable ufw

# audio
sudo pacman -S ffmpeg ffmpegthumbs pipewire pipewire-alsa pipewire-pulse pulseeffects

# install paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# packages
sudo pacman -S firefox discord
paru -S cryptomator spotify obsidian-appimage

# gaming
sudo pacman -S wine-staging wine_gecko wine-mono winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
sudo pacman -S gamemode steam steam-native-runtime lutris

# zsh
chsh -s /usr/bin/zsh
