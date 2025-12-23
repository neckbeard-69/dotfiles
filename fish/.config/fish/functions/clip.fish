function clip
    cliphist list | fzf --no-sort --tac --prompt="Clipboard> " | cliphist decode | wl-copy
    echo "Text copied"
end
