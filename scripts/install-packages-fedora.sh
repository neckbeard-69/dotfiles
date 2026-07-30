#!/usr/bin/env bash
set -euo pipefail

# Fedora only
grep -qi fedora /etc/os-release || {
    echo "Fedora only."
    exit 1
}

# Don't run as root
[ "$EUID" -ne 0 ] || {
    echo "Run as a normal user."
    exit 1
}

sudo dnf install -y curl git

# Homebrew
if ! command -v brew >/dev/null; then
    NONINTERACTIVE=1 bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$("$(command -v brew)" shellenv)"

grep -qxF 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.bashrc || \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

mkdir -p ~/.config/fish/conf.d
cat > ~/.config/fish/conf.d/brew.fish <<'EOF'
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
EOF

sudo dnf copr enable -y alternateved/keyd || true

sudo dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

curl -fsS https://dl.brave.com/install.sh | FLAVOR=origin sh

DNF_PKGS=(
    stow
    git
    fish
    tmux
    neovim
    vscodium
    fd-find
    fzf
    ripgrep
    eza
    btop
    cloc
    fastfetch
    zoxide
    pavucontrol
    brightnessctl
    libnotify
    jetbrains-mono-fonts
    wl-clipboard
    grim
    slurp
    nodejs
    golang
    rust
    cargo
    gcc
    openssl
    docker
    docker-compose
    wireplumber
    ly
    postgresql
    flatpak
    NetworkManager
    keyd
    openvpn3
    tree-sitter
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    cups
    obs-studio
    pritunl-client
)

for pkg in "${DNF_PKGS[@]}"; do
    echo "Installing $pkg..."
    sudo dnf install -y "$pkg" || echo "Skipping $pkg"
done

HYPR_DEPS=(
    cmake
    ninja-build
    wayland-devel
    libdrm-devel
    libxkbcommon-devel
    cairo-devel
    pango-devel
    mesa-libEGL-devel
    libglvnd-devel
    libdisplay-info-devel
    libinput-devel
    systemd-devel
    hwdata-devel
    udis86-devel
    glslang
    python3
    xcb-util-errors-devel
    xcb-util-wm-devel
    libxcb-devel
    xcb-util-image-devel
    xcb-util-renderutil-devel
    pkgconfig
)

for pkg in "${HYPR_DEPS[@]}"; do
    sudo dnf install -y "$pkg" || echo "Skipping $pkg"
done

build_repo() {
    local repo=$1
    local dir="/tmp/$(basename "$repo")"

    if [ ! -d "$dir" ]; then
        git clone --recursive "$repo" "$dir"
    fi

    cd "$dir"

    git fetch --tags --force

    local tag
    tag=$(git tag -l 'v*' --sort=-version:refname | head -1)

    git checkout "$tag"
    git submodule update --init --recursive --force

    if [ -f Makefile ]; then
        make -j"$(nproc)"
        sudo make install
    else
        cmake -B build
        cmake --build build -j"$(nproc)"
        sudo cmake --install build
    fi
}

build_repo https://github.com/hyprwm/Hyprland
build_repo https://github.com/hyprwm/xdg-desktop-portal-hyprland

BREW_PKGS=(
    lazygit
    sk
    golangci-lint
    lazydocker
    lazysql
    air
    sqlc
    lua-language-server
    localsend
    foliate
    batsignal
    satty
)

for pkg in "${BREW_PKGS[@]}"; do
    echo "Installing brew package: $pkg"
    brew install "$pkg" || echo "Skipping $pkg"
done

GO_PKGS=(
    golang.org/x/tools/gopls@latest
    github.com/nametake/golangci-lint-langserver@latest
	github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
)

for pkg in "${GO_PKGS[@]}"; do
    echo "Installing Go tool: $pkg"
    go install "$pkg" || echo "Skipping $pkg"
done

NPM_PKGS=(
    pnpm
    typescript-language-server
    @tailwindcss/language-server
)

for pkg in "${NPM_PKGS[@]}"; do
    sudo npm install -g "$pkg" || echo "Skipping $pkg"
done

command -v dms >/dev/null || \
    curl -fsSL https://install.danklinux.com | sh

flatpak remote-add --if-not-exists \
    flathub \
    https://flathub.org/repo/flathub.flatpakrepo

flatpak update -y

FLATPAK_APPS=(
    io.beekeeperstudio.Studio
    com.usebruno.Bruno
)

for app in "${FLATPAK_APPS[@]}"; do
    flatpak install -y flathub "$app" || echo "Skipping $app"
done

echo "Done!"
