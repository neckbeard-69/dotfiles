echo "linking fish.."
rm -rf ~/.config/fish
stow ../fish

echo "linking nvim..."
stow ../neovim

echo "linking ghostty..."
stow ../ghostty

echo "linking niri..."
stow ../niri

echo "linking tmux..."
stow ../tmux

echo "linking yazi..."
stow ../yazi

starship preset nerd-font-symbols -o ~/.config/starship.toml
