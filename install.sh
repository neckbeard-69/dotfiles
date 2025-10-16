#!/bin/bash
# AN ARCH LINUX ONLY SCRIPT (BTW :3)

GREEN="\033[0;32m"
RESET="\033[0m"

echo -n "Are you sure you want to proceed with the installation? (y/n)"
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Exiting ..."
    exit 1
fi

# Get non-dot directories
directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \; | grep -v '^\.')

mkdir -p ~/cachyos-repos
cd ~/cachyos-repos
echo "adding cachyos repos..."
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
cd ~/dotfiles

echo "Installing stow"
sudo pacman -S --noconfirm stow
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
stow fish
fisher install jorgebucaran/autopair.fish

for dir in $directories; do
    if [ -d "$dir" ]; then
        echo "Stowing directory: $dir"
        stow $dir
    fi
done

echo "Stowing complete. Now installing packages..."

for dir in $directories; do
    if [ -d "$dir" ]; then
        echo "Installing package: $dir"
        sudo pacman -S --noconfirm $dir
    fi
done

echo "Installation complete."


echo "Installing extra packages ..."
packages=(
  sway swaybg autotiling swaync brightnessctl nwg-look # sway stuff
  xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr # wayland stuff
  wireplumber blueman bluez
  rofi-wayland fzf skim bat zoxide ripgrep gammastep keyd # tools
  adw-gtk-theme ttf-jetbrains-mono-nerd
  qt5-base qt5-wayland qt6-base qt6-wayland # dependencies
  cachyos-settings
  discord 
  yay
  brave-bin # browser
  go bun npm docker docker-compose # dev tools
)

for pkg in "${packages[@]}"; do
  if sudo pacman -Si "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    sudo pacman -S --noconfirm --needed "$pkg"
  else
    echo "Warning: Package '$pkg' not found."
    read -rp "Press Enter to continue installing the next packages..."
  fi
done

echo "Installing extra AUR packages..."
yay -S --noconfirm waypaper sway-screenshot exa
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd
sudo systemctl start keyd --now
sudo keyd reload
chsh -s /usr/bin/fish
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -sS https://starship.rs/install.sh | sh
fish -c "fish_vi_key_bindings"


# Some additional settings
sudo systemctl enable docker --now
sudo usermod -aG docker $USER

cp ./ly.service /lib/systemd/system/ # enable full rbg in external monitor (connector and property nums should be changed if it did not work)

read -p "Enter your email for git: " email
read -p "Enter your name for git: " name
git config --global user.name "$name"
git config --global user.email "$email"
ssh-keygen -t ed25519 -C "github:$email" -f ~/.ssh/github -N ""

github_ssh_key=$(<~/.ssh/github.pub)
echo -e "YOUR GITHUB SSH KEY:\n${GREEN}${github_ssh_key}${RESET}"

bash ./change-dns.sh

echo "Setup complete. REBOOT FFS"
