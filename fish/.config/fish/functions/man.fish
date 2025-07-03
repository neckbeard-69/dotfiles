function man
    command man $argv | col -bx | nvim -R -c "set ft=man" -
end
