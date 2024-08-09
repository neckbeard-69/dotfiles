# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

alias nv=nvim
alias gti=git
alias fv='nvim $(fzf -m --preview="bat --color=always {}")'

alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias c="clear"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=( 
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux
BAT_THEME="Catppuccin Mocha"

nerdfetch
tmux
export EDITOR=nvim
export VISUAL=nvim
### From this line is for pywal-colors
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh

eval "$(starship init zsh)"
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
