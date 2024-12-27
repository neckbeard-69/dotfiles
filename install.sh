#!/bin/bash

# AN ARCH LINUX ONLY SCRIPT (BTW :3)

directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \;)

echo "Installing stow"
sudo pacman -S --noconfirm stow

for dir in $directories; do
    if [ -d "$dir" ] && [ "$(basename "$dir")" != ".git" ]; then
        echo "Stowing directory: $dir"
        stow $dir
    fi
done

echo "Stowing complete. Now installing packages..."

for dir in $directories; do
    if [ -d "$dir" ] && [ "$(basename "$dir")" != ".git" ]; then
        echo "Installing package: $dir"
        sudo pacman -S --noconfirm $dir
    fi
done

echo "Installation complete."


echo "Installing extra packages ..."
sudo pacman -S --noconfirm swaybg rofi i3 xdg-desktop-portal xdg-desktop-portal-wlr wireplumber blueman bluez discord autotiling brightnessctl swaync fzf zsh bat

echo "Installing yay..."
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..

echo "Installing extra AUR packages..."
yay -S --noconfirm waypaper sway-screenshot ttf-rubik ttf-jetbrains-mono-nerd 
chsh -s /usr/bin/zsh
rm ~/.zshrc
rm ~/.zshenv
stow zsh
source ~/.zshrc
bat cache --build
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
echo "Setup complete."
