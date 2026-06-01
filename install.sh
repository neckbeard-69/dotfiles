#!/bin/bash
# AN ARCH LINUX ONLY SCRIPT (BTW :3)

echo -n "Are you sure you want to proceed with the installation? (y/n)"
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Exiting ..."
    exit 1
fi

mkdir ~/repos
cd ~/repos
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
cd ~/dotfiles
rm -rf ~/repos

# Get non-dot directories
directories=$(find . -maxdepth 1 -type d -not -path '.' -exec basename {} \; | grep -v '^\.')

rm -rf ~/.config/fish
echo "Installing stow"
sudo pacman -S --noconfirm stow


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
  swaybg brightnessctl nwg-look 
  xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr wl-clipboard # wayland stuff
  wireplumber blueman bluez
  thunar
  fzf skim bat zoxide ripgrep wlsunset keyd satty grim cliphist qt5ct localsend flatpak # tools
  adw-gtk-theme ttf-jetbrains-mono-nerd nautilus file-roller unzip p7zip unrar
  qt5-base qt5-wayland qt6-base qt6-wayland # dependencies
  discord 
  quickshell
  yay
  power-profiles-daemon pipewire-pulse
  xdg-desktop-portal-hyprland
  pavucontrol
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
starship preset nerd-font-symbols -o ~/.config/starship.toml
fish -c "fish_vi_key_bindings"


curl -fsSL https://install.danklinux.com | sh
# Some additional settings
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
sudo systemctl enable ly@tty1.service


read -p "Enter your email for git: " email
read -p "Enter your name for git: " name
git config --global user.name "$name"
git config --global user.email "$email"

sudo systemctl enable --now power-profiles-daemon.service

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
mkdir -p ~/.config/fontconfig/conf.d/
cp ./10-arabic-priority.conf ~/.config/fontconfig/conf.d/
fc-cache -fv
reboot
