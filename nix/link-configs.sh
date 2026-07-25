#!/bin/sh

cd ../

echo "linking fish.."
rm -rf ~/.config/fish
stow fish

echo "linking nvim..."
stow neovim

echo "linking ghostty..."
stow ghostty

echo "linking niri..."
stow niri

echo "linking tmux..."
stow tmux

echo "linking yazi..."
stow yazi

echo "linking dms.."
stow dms

echo "linking fastfech..."
stow fastfetch

echo "linking vs codium..."
stow vs-codium

starship preset nerd-font-symbols -o ~/.config/starship.toml

sudo mkdir -p /etc/keyd
sudo cp ./default.conf /etc/keyd/


mkdir -p ~/.local/share/applications
ln -s /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/
