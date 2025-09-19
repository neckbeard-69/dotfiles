function remove
    set pkg (pacman -Qq | fzf)
    if test -n "$pkg"
        sudo pacman -Rns $pkg
    end
end
