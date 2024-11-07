#!/bin/bash

# NOTE: this script only works for arch linux

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \;)

echo "Installing stow"
pacman -S --noconfirm stow

for dir in $directories; do
    echo "Stowing directory: $dir"
    stow $dir
done

echo "Stowing complete. Now installing packages."

for dir in $directories; do
    echo "Installing package: $dir"
    pacman -S --noconfirm $dir
done

echo "Installation complete."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"