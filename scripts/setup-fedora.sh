#!/bin/bash
set -euo pipefail

info()  { printf "\n[INFO] %s\n" "$1"; }
ok()    { printf "[OK]   %s\n" "$1"; }

DOTFILES_DIR="$HOME/dotfiles"

if ! grep -qi "fedora" /etc/os-release; then
    echo "This script is for Fedora only" >&2
    exit 1
fi

if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root" >&2
    exit 1
fi

# ============================================
# Firewall (localsend port)
# ============================================
info "Configuring firewall..."
sudo firewall-cmd --permanent --add-port=53317/tcp
sudo firewall-cmd --permanent --add-port=53317/udp
sudo firewall-cmd --reload
ok "Ports 53317/tcp+udp opened for localsend"

# ============================================
# systemd-resolved DNS
# ============================================
info "Configuring systemd-resolved..."
sudo mkdir -p /etc/systemd/resolved.conf.d
cat <<'EOF' | sudo tee /etc/systemd/resolved.conf.d/dns.conf >/dev/null
[Resolve]
DNS=1.1.1.1 1.0.0.1
FallbackDNS=8.8.8.8 8.8.4.4
DNSOverTLS=yes
EOF
sudo rm -f /etc/resolv.conf
sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo systemctl enable --now systemd-resolved
ok "DNS configured with Cloudflare + DoT"

# ============================================
# Shell — fish
# ============================================
info "Changing default shell to fish..."
FISH_PATH=$(command -v fish)
if ! grep -qx "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
    ok "Default shell changed to fish (effective after next login)"
else
    ok "Shell already fish"
fi

# ============================================
# Services
# ============================================
info "Enabling system services..."
sudo systemctl enable --now docker
sudo systemctl enable --now ly@tty1
sudo systemctl disbale --now gdm
ok "Services enabled"

# ============================================
# User groups
# ============================================
info "Adding user to groups..."
sudo usermod -aG docker "$USER"
sudo usermod -aG networkmanager "$USER" 2>/dev/null || true
ok "User added to docker, networkmanager groups"

# ============================================
# Keyd
# ============================================
if [ -f "$DOTFILES_DIR/default.conf" ]; then
    info "Setting up keyd..."
    sudo cp "$DOTFILES_DIR/default.conf" /etc/keyd/default.conf
    sudo systemctl enable --now keyd
    sudo keyd reload
    ok "Keyd configured"
else
    echo "default.conf not found at $DOTFILES_DIR/default.conf — skipping keyd"
fi

# ============================================
# Git
# ============================================
if ! git config --global user.name &>/dev/null; then
    read -p "Enter your email for git: " email
    read -p "Enter your name for git: " name
    git config --global user.name "$name"
    git config --global user.email "$email"
    ok "Git configured"
else
    ok "Git already configured"
fi

# ============================================
# Fish vi key bindings
# ============================================
if [ ! -f ~/.config/fish/conf.d/vi-mode.fish ]; then
    mkdir -p ~/.config/fish/conf.d
    fish -c "fish_vi_key_bindings"
    ok "Fish vi key bindings enabled"
fi

# ============================================
# User directories
# ============================================
info "Setting up user directories..."
xdg-user-dirs-update 2>/dev/null || true
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/.local/bin"

info "Setup complete! A reboot is recommended."
