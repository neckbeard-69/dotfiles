#!/bin/bash
set -euo pipefail

info()  { printf "\n[INFO] %s\n" "$1"; }
ok()    { printf "[OK]   %s\n" "$1"; }
error() { printf "\n[ERROR] %s\n" "$1" >&2; exit 1; }

if ! grep -qi "fedora" /etc/os-release; then
    error "This script is for Fedora only"
fi

if [ "$EUID" -eq 0 ]; then
    error "Do not run this script as root"
fi

# ============================================
# Phase 1: Prerequisites
# ============================================
info "Installing prerequisites..."
sudo dnf install -y curl git

# ============================================
# Phase 2: Homebrew
# ============================================
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    mkdir -p ~/.config/fish/conf.d
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' > ~/.config/fish/conf.d/brew.fish
else
    ok "Homebrew already installed"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ============================================
# Phase 3: COPR and third-party repos
# ============================================
info "Enabling COPR repositories..."
sudo dnf copr enable -y alternateved/keyd

info "Adding RPM Fusion..."
sudo dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

sudo dnf upgrade -y

if ! command -v codium &>/dev/null; then
    info "Adding VSCodium repository..."
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    cat <<'EOF' | sudo tee /etc/yum.repos.d/vscodium.repo >/dev/null
[vscodium]
name=VSCodium
baseurl=https://download.vscodium.com/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
metadata_expire=1h
EOF
fi

curl -fsS https://dl.brave.com/install.sh | FLAVOR=origin sh

if ! command -v pritunl-client &>/dev/null; then
    info "Adding Pritunl repository..."
    cat <<'EOF' | sudo tee /etc/yum.repos.d/pritunl.repo >/dev/null
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/fedora/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo.pub
EOF
fi

# ============================================
# Phase 4: dnf system packages
# ============================================
info "Installing system packages via dnf..."

sudo dnf install -y \
    stow git fish tmux \
    neovim vscodium \
    fd-find fzf ripgrep eza btop cloc fastfetch \
    zoxide \
    pavucontrol brightnessctl libnotify \
    jetbrains-mono-fonts \
    wl-clipboard grim slurp \
    nodejs rust cargo gcc openssl \
    docker docker-compose \
    wireplumber \
    ly postgresql \
    flatpak NetworkManager keyd openvpn3 \
    tree-sitter \
    xdg-desktop-portal xdg-desktop-portal-gtk \
    cups

sudo dnf install -y pritunl-client
sudo dnf install -y obs-studio

# ============================================
# Phase 5: Hyprland — build from source
# ============================================
info "Installing Hyprland build dependencies..."
sudo dnf install -y \
    cmake ninja-build \
    wayland-devel libdrm-devel libxkbcommon-devel \
    cairo-devel pango-devel \
    mesa-libEGL-devel libglvnd-devel \
    libdisplay-info-devel libinput-devel \
    systemd-devel hwdata-devel \
    udis86-devel glslang \
    python3 \
    xcb-util-errors-devel xcb-util-wm-devel \
    libxcb-devel xcb-util-image-devel xcb-util-renderutil-devel \
    pkgconfig

HYPRLAND_DIR="/tmp/Hyprland"
if [ ! -d "$HYPRLAND_DIR" ]; then
    git clone --recursive https://github.com/hyprwm/Hyprland "$HYPRLAND_DIR"
fi

cd "$HYPRLAND_DIR"
git fetch --tags --force
latest_tag=$(git tag -l 'v*' --sort=-version:refname | head -n1)
info "Building Hyprland ${latest_tag} from source..."
git checkout "$latest_tag"
git submodule update --init --recursive --force
make all -j"$(nproc)"
sudo make install

XDPH_DIR="/tmp/xdg-desktop-portal-hyprland"
if [ ! -d "$XDPH_DIR" ]; then
    git clone https://github.com/hyprwm/xdg-desktop-portal-hyprland "$XDPH_DIR"
fi

cd "$XDPH_DIR"
git fetch --tags --force
latest_tag=$(git tag -l 'v*' --sort=-version:refname | head -n1)
git checkout "$latest_tag"
git submodule update --init --recursive --force
cmake -B build
cmake --build build -j"$(nproc)"
sudo cmake --install build

# ============================================
# Phase 6: Brew — user-facing tools
# ============================================
info "Installing user-facing tools via Homebrew..."

BREW_PKGS=(
    lazygit skim golangci-lint lazydocker
    lazysql air sqlc ghostty lua-language-server
    bruno beekeeper-studio localsend foliate
    batsignal satty
)

for pkg in "${BREW_PKGS[@]}"; do
    if ! brew list "$pkg" &>/dev/null 2>&1; then
        brew install "$pkg" || info "brew install $pkg failed (continuing)"
    else
        ok "$pkg already installed"
    fi
done

# ============================================
# Phase 7: Latest Go
# ============================================
sudo dnf install golang

# ============================================
# Phase 8: Go tools
# ============================================
info "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install github.com/nametake/golangci-lint-langserver@latest

# ============================================
# Phase 9: NPM global tools
# ============================================
info "Installing NPM global packages..."
sudo npm install -g pnpm
sudo npm add -g typescript-language-server
sudo npm add -g @tailwindcss/language-server


# ============================================
# Phase 11: DMS shell
# ============================================
if ! command -v dms &>/dev/null; then
    info "Installing DMS shell..."
    curl -fsSL https://install.danklinux.com | sh
fi

# ============================================
# Phase 12: Flatpak
# ============================================
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y

info "All packages installed!"
echo "Run setup-fedora.sh to finish configuration."
