set -g fish_greeting ""
# source ~/.local/bin/vulkansdk/setup.fish
eval "$(zoxide init --cmd cd fish)"
alias vim=nvim
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ls='exa --group-directories-first --icons --git --color=always -F'
alias c="clear"
alias e="exit"
alias cat="/usr/bin/bat"
alias bat="/usr/bin/cat"

function addToPath
    if test -d $argv[1]
        set -l new_path (realpath $argv[1])
        if not contains $new_path $PATH
            set -gx PATH $PATH $new_path
        end
    else
        echo "Error: $argv[1] is not a directory"
    end
end

if not pgrep -u (whoami) ssh-agent > /dev/null
    eval (ssh-agent -c)
end
starship init fish | source
ssh-add ~/.ssh/id_ed25519 2>/dev/null

addToPath $HOME/go/bin
addToPath ~/.local/bin/
addToPath (ruby -r rubygems -e 'puts Gem.user_dir')/bin
# addToPath $HOME/.bun/bin

# Set environment variables
set -x QT_QPA_PLATFORM wayland
# set -x XDG_CURRENT_DESKTOP sway
# set -x XDG_SESSION_DESKTOP sway
set -x XDG_CURRENT_SESSION_TYPE wayland
set -x GDK_BACKEND "wayland,x11"
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x WLR_DRM_NO_MODIFIERS 1
set -x EDITOR nvim
set -x VISUAL nvim
# clear

# keybinds
bind ctrl-n 'fzf | xargs nvim'
bind ctrl-f 'cd (fzf | xargs dirname)'

# pnpm
set -gx PNPM_HOME "/home/mohammed/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


