# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

alias v=nvim
alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias c="clear"
alias e="exit"
alias vite-new="npm create vite@latest"
bindkey -s '^F' 'cd "$(dirname "$(find . -type f -o -type d | fzf)")"\n' # cd into the containing dir of a file or dir
bindkey -s '^V' 'nvim $(fzf -m --preview="bat --color=always {}")\n' # open a file in neovim
bindkey '^K' autosuggest-accept

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="robbyrussell"

plugins=( 
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


export EDITOR=nvim
export VISUAL=nvim
go() {
    if [ "$1" = "test" ]; then
        shift
        command go test "$@" | colout 'PASS' green | colout 'Passed' green | colout "ok" green \
                              | colout 'FAIL' red | colout 'fail' red \
                              | colout 'FAILED' red | colout 'failed' red \
                              | colout 'FAILURE' red | colout 'failure' red
    else
        command go "$@"
    fi
}
export HYPRLAND_INSTANCE_SIGNATURE=$(date +%s)

export PATH=$PATH:$HOME/go/bin

PATH=~/.console-ninja/.bin:$PATH

# bun completions
[ -s "/home/mohammed/.oh-my-zsh/completions/_bun" ] && source "/home/mohammed/.oh-my-zsh/completions/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export XDG_CURRENT_DESKTOP=sway
