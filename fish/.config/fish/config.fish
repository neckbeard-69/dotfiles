set -g fish_greeting ""
eval "$(zoxide init --cmd cd fish)"
alias vim=nvim
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ls='eza --group-directories-first --icons --git --color=always -F'
alias c="clear"
alias e="exit"
alias emu="env QT_QPA_PLATFORM=xcb emulator -avd flutter_emulator"
alias lst="ls -T"

eval (ssh-agent -c) >/dev/null 2>&1

for key in ~/.ssh/*
    if test -f $key; and not string match -q '*.pub' $key; and not string match -q 'known_hosts*' $key
        ssh-add $key >/dev/null 2>&1
    end
end
starship init fish | source

fish_add_path $HOME/go/bin
fish_add_path ~/.local/bin/
fish_add_path $HOME/.bun/bin
fish_add_path -g -p $HOME/flutter/bin/
set -gx ANDROID_SDK_ROOT $HOME/Android
set -gx ANDROID_HOME $HOME/Android

fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/build-tools/33.0.2/
fish_add_path $HOME/dotfiles/.bin
fish_add_path $HOME/.pub-cache/global_packages
fish_add_path $HOME/.pub-cache/bin

# Set environment variables
set -x QT_QPA_PLATFORM wayland
set -x XDG_CURRENT_DESKTOP niri
set -x GDK_BACKEND "wayland,x11"
set -x MOZ_ENABLE_WAYLAND 1
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x WLR_DRM_NO_MODIFIERS 1
set -x EDITOR nvim
set -x VISUAL nvim


# pnpm
set -gx PNPM_HOME "/home/mohammed/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# set -gx ANDROID_HOME $HOME/Android/Sdk
