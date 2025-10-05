function tms
    if test (count $argv) -eq 1
        set selected $argv[1]
    else
        set selected (find ~/Desktop/code -mindepth 1 -maxdepth 1 -type d | fzf)
    end

    if test -z "$selected"
        return 0
    end

    set selected_name (basename $selected | string replace '.' '_')

    set tmux_running (pgrep tmux)

    if test -z "$TMUX" -a -z "$tmux_running"
        tmux new-session -s $selected_name -c $selected
        return 0
    end

    if not tmux has-session -t $selected_name ^/dev/null
        tmux new-session -ds $selected_name -c $selected
    end

    if test -n "$TMUX"
        tmux switch-client -t $selected_name
    else
        tmux attach-session -t $selected_name
    end
end
