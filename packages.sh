#!/bin/bash
sudo pacman -Syu

# "essenstials"
sudo pacman -S alacritty alsa-utils dunst curl htop hunspell{-es_any,-en_US} gnupg libmpt lsd neovim numlockx screenfetch ufw gufw wget zsh zsh-completions zip xclip xdotool xsel xwallpaper

# fonts
sudo pacman -S adobe-source-{code-pro-fonts,han-sans-jp-fonts,han-serif-jp-fonts} noto-fonts{,-cjk,-emoji,-extra} ttf-{hack,anonymous-pro,dejavu,freefont,liberation,roboto,bitstream-vera,croscore,droid,ubuntu-font-family} lib32-fontconfig wqy-zenhei
#paru -S ttf-ms-fonts

# zsh
sudo pacman -S zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting 

# JP Keyboard support
sudo pacman -S fcitx{-im,-configtool,-mozc}

# Theming
# https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/#hardcoded-icons
sudo pacman -S arc-gtk-theme capitaine-cursors kvantum-qt5 qt5ct

# ufw
sudo ufw enable
sudo systemctl enable ufw

# audio
sudo pacman -S ffmpeg pipewire pipewire-alsa pipewire-pulse pulsemixer playerctl

# file manager: ranger
sudo pacman -S ranger atool ffmpegthumbnailer highlight mediainfo ueberzug

# mount devices
sudo pacman -S udiskie 

# rofi
sudo pacman -S rofi rofimoji

# packages
sudo pacman -S anki mpv firefox flameshot foliate discord redshift sxiv network-manager-applet pitivi gst-plugins-ugly

# gaming
sudo pacman -S wine-staging wine_gecko wine-mono winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader lib32-alsa-plugins lib32-dbus lib32-freetype2 lib32-gnutls lib32-libcrypt lib32-libgpg-error lib32-libldap lib32-libxml2 lib32-sdl2 libgcrypt
sudo pacman -S gamemode steam steam-native-runtime lutris

echo "Packages installed!"
echo "Reboot your system and install Paru AUR Helper with packages-aur.sh"
chmod +x packages-aur.sh
echo ""
echo "To exit the installation run: exit & umount /mnt/boot & umount /mnt/home & umount /mnt & reboot"
