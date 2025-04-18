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

# remove cahcyos garbage bloated config
rm -rf ~/.config/fish
rm -rf ~/.local/share/fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
stow fish

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
sudo pacman -S --noconfirm sway swaybg rofi xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr wireplumber blueman bluez discord autotiling brightnessctl swaync fzf zsh bat zoxide gammastep exa yay zen-browser-bin nemo nemo-fileroller qt5-wayland qt6-wayland

sudo pacman -Rns --noconfirm paru

echo "Installing extra AUR packages..."
yay -S --noconfirm waypaper sway-screenshot ttf-jetbrains-mono-nerd keyd-git themechanger-git
 
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd
sudo systemctl start keyd --now
sudo keyd reload
chsh -s /usr/bin/fish
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins # install tmux plugins
bat cache --build

fish -c "
    fish_vi_key_bindings
    fisher install vitallium/tokyonight-fish
    fish_config theme save "TokyoNight Storm"
"
echo "Setup complete."

