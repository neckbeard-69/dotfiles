#!/bin/bash
# AN ARCH LINUX ONLY SCRIPT (BTW :3)

echo -n "Are you sure you want to proceed with the installation? (y/n)"
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Exiting ..."
    exit 1
fi

# Get non-dot directories
directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \; | grep -v '^\.')

rm -rf ~/.config/fish
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

curl -fsSL https://install.danklinux.com | sh
echo "Stowing complete. Now installing packages..."

for dir in $directories; do
    if [ -d "$dir" ]; then
        echo "Installing package: $dir"
        sudo pacman -S --noconfirm $dir
    fi
done

echo "Installation complete."

sudo pacman -Rns paru --noconfirm
echo "Installing extra packages ..."
packages=(
  swaybg brightnessctl nwg-look 
  xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr wl-clipboard # wayland stuff
  wireplumber blueman bluez
  thunar
  fzf skim bat zoxide ripgrep wlsunset keyd satty grim cliphist qt5ct localsend flatpak # tools
  adw-gtk-theme ttf-jetbrains-mono-nerd
  qt5-base qt5-wayland qt6-base qt6-wayland # dependencies
  discord 
  quickshell
  yay
  helium-browser-bin # browser
  go bun pnpm npm docker docker-compose github-cli lazygit lazydocker # dev tools
  ly
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
yay -S --noconfirm waypaper exa
sudo cp ./default.conf /etc/keyd/
sudo systemctl enable keyd
sudo systemctl start keyd --now
sudo keyd reload
chsh -s /usr/bin/fish
curl -sS https://starship.rs/install.sh | sh
fish -c "fish_vi_key_bindings"


# Some additional settings
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
sudo systemctl enable ly@tty1.service


read -p "Enter your email for git: " email
read -p "Enter your name for git: " name
git config --global user.name "$name"
git config --global user.email "$email"


bash ./change-dns.sh
xdg-user-dirs-update
mkdir -p ~/go/bin
mkdir -p ~/.bun/bin
mkdir -p ~/.local/bin

# fix noctalia shell launcher and flatpak
mkdir -p ~/.local/share/applications
ln -s /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/


# open localsend ports
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp
sudo ufw reload

reboot
