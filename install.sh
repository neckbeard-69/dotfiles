#!/usr/bin/env bash
# this script is ai genereated, maybe broken
set -e

echo -n "Are you sure you want to proceed with the installation? (y/n): "
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Exiting..."
    exit 1
fi

echo "Updating system..."
sudo dnf upgrade --refresh -y

echo "Installing base tools..."
sudo dnf install -y \
    stow curl git fish dnf-plugins-core

# Enable COPR repos (Hyprland ecosystem + extras)
echo "Enabling COPR repositories..."
sudo dnf copr enable -y solopasha/hyprland
sudo dnf copr enable -y atim/starship
sudo dnf copr enable -y varlad/zellij || true
sudo dnf copr enable avengemedia/dms -y
sudo dnf copr enable alternateved/keyd -y
sudo dnf copr enable atim/lazygit -y
sudo dnf copr enable atim/lazydocker -y

# Get non-dot directories
directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \; | grep -v '^\.')

# Stow dotfiles
for dir in $directories; do
    if [[ -d "$HOME/.config/$dir" ]]; then
        echo "Removing existing ~/.config/$dir ..."
        rm -rf "$HOME/.config/$dir"
    elif [[ -d "$HOME/$dir" ]]; then
        echo "Removing existing ~/$dir ..."
        rm -rf "$HOME/$dir"
    fi

    echo "Stowing $dir ..."
    stow "$dir"
done

stow .dms
sudo dnf install quickshell
sudo dnf install dms

echo "Installing packages..."

packages=(
  # Hyprland / Wayland
  hyprland swaybg brightnessctl
  xorg-x11-server-Xwayland xdg-desktop-portal xdg-desktop-portal-hyprland wl-clipboard
  hyprshot

  # System
  wireplumber blueman bluez

  # CLI tools
  fzf bat zoxide ripgrep
  wlsunset grim slurp cliphist
  keyd satty

  # UI / fonts
  jetbrains-mono-fonts
  # Apps
  flatpak discord

  # Dev tools
  golang nodejs nodejs-npm pnpm docker-cli docker-compose lazygit lazydocker

  # Terminal / misc
  tmux neovim starship
)

for pkg in "${packages[@]}"; do
    echo "Installing $pkg..."
    sudo dnf install -y "$pkg" || echo "Warning: Failed to install $pkg"
done

echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# keyd setup
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd --now
sudo keyd reload

# Enable services
sudo systemctl enable docker --now
sudo usermod -aG docker "$USER"

# Set shell
chsh -s /usr/bin/fish

# Git config
read -p "Enter your email for git: " email
read -p "Enter your name for git: " name
git config --global user.name "$name"
git config --global user.email "$email"

# DNS script
bash ./change-dns.sh

# Create dirs
mkdir -p ~/go/bin
mkdir -p ~/.bun/bin
mkdir -p ~/.local/bin

# Flatpak fix
mkdir -p ~/.local/share/applications
ln -sf /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/

# Firewall (firewalld)
echo "Opening LocalSend ports..."
sudo firewall-cmd --permanent --add-port=53317/tcp
sudo firewall-cmd --permanent --add-port=53317/udp
sudo firewall-cmd --reload

echo "Done. Rebooting..."
reboot
