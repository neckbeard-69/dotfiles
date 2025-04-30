set -g fish_greeting ""
# source ~/.local/bin/vulkansdk/setup.fish
eval "$(zoxide init --cmd cd fish)"
alias v=nvim
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ls='exa'
alias c="clear"
alias e="exit"

function addToPath
    set -l new_path (realpath $argv[1]) 
    if not contains $new_path $PATH
        set -gx PATH $PATH $new_path 
    end
end

# if not pgrep -u (whoami) ssh-agent > /dev/null
#     eval (ssh-agent -c)
# end

# ssh-add ~/.ssh/id_ed25519 2>/dev/null

# addToPath $HOME/.local/bin/zig
# addToPath $HOME/.local/bin/gonm
# addToPath $HOME/.local/bin/vulkansdk

# Set environment variables
set -x QT_QPA_PLATFORM wayland
set -x XDG_CURRENT_DESKTOP sway
set -x XDG_SESSION_DESKTOP sway
set -x XDG_CURRENT_SESSION_TYPE wayland
set -x GDK_BACKEND "wayland,x11"
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x WLR_DRM_NO_MODIFIERS 1
set -x EDITOR nvim
set -x VISUAL nvim
# eval (ssh-agent -c)
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
