#!/bin/bash
# a script to set up my work laptop on fedora

# stow configs ---
stow neovim fish tmux sway ghostty mako
# ---

sudo dnf install sway neovim fish tmux stow docker lazygit lazydocker rofi git ufw grim slurp mako swaybg wlsunset

# Go ---
sudo dnf install golang
go install golang.org/x/tools/gopls@latest # gopls
go install github.com/nametake/golangci-lint-langserver@latest # golangci-lint-langserver
sudo dnf install golangci-lint
# ---

# ghostty ---
sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty
# ---

# swayosd ---
dnf copr enable erikreider/swayosd
dnf install swayosd
# ---

# i3status-rust ---
sudo dnf copr enable alternateved/i3status-rust
sudo dnf install i3status-rust
# ---

# satty ---
sudo dnf copr enable mineiro/satty
sudo dnf install satty
# ---

# keyd ---
sudo dnf copr enable alternateved/keyd
sudo dnf install keyd
# ---


# zen browser ---
sudo dnf copr enable sneexy/zen-browser
sudo dnf install zen-browser
# ---

# other
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd
sudo systemctl start keyd --now
sudo keyd reload

chsh -s /usr/bin/fish
curl -sS https://starship.rs/install.sh | sh
starship preset nerd-font-symbols -o ~/.config/starship.toml
fish -c "fish_vi_key_bindings"

read -p "Enter your email for git: " email
read -p "Enter your name for git: " name
git config --global user.name "$name"
git config --global user.email "$email"


# open localsend posts
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp
sudo ufw reload
