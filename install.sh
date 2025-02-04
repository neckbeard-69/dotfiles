#!/bin/bash
# AN ARCH LINUX ONLY SCRIPT (BTW :3)

echo -n "Are you sure you want to proceed with the installation? (y/n)"
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Exitting ..."
    exit 1
fi

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
sudo pacman -S --noconfirm swaybg rofi i3 xdg-desktop-portal xdg-desktop-portal-wlr wireplumber blueman bluez discord autotiling brightnessctl swaync fzf zsh bat zoxide gammastep yazi


echo "Installing extra AUR packages..."
paru -S --noconfirm waypaper sway-screenshot ttf-jetbrains-mono-nerd keyd-git zen-browser-bin
 
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd
sudo systemctl start keyd --now
sudo keyd reload
chsh -s /usr/bin/zsh
rm ~/.zshrc
rm ~/.zshenv
stow zsh
source ~/.zshrc
bat cache --build
sudo systemctl enable bluetooth
sudo systemctl start bluetooth 
echo "Setup complete."


