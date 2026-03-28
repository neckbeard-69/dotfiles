function sc
    set dir (fd --type d --maxdepth 1 . ~/dotfiles/*/.config | fzf)
    if test -n "$dir"
        cd $dir
        nvim .
    end
end
