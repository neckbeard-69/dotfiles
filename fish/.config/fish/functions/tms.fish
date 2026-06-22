function tms
    if test (count $argv) -eq 1
        set selected $argv[1]
    else
        set base ~/Projects/
        set level1 (find $base -mindepth 1 -maxdepth 1 -type d)
        set level2 (find $base -mindepth 2 -maxdepth 2 -type d \( -name backend -o -name frontend \))
        set selected (printf "%s\n" $level1 $level2 | sk)
    end

    if test -z "$selected"
        return 0
    end

    set selected_name (basename $selected | string replace '.' '_')
    set tmux_running (pgrep tmux)

    if test -z "$TMUX" -a -z "$tmux_running"
        tmux new-session -d -s "$selected_name" -c "$selected"

        tmux new-window -t "$selected_name:1" -c "$selected"
        tmux new-window -t "$selected_name:2" -n shell -c "$selected"
        tmux new-window -t "$selected_name:3" -n lazygit -c "$selected" lazygit
        tmux new-window -t "$selected_name:4" -n server -c "$selected"

        tmux select-window -t "$selected_name:1"
        tmux attach-session -t $selected_name
        return 0
    end

    if not tmux has-session -t $selected_name ^/dev/null
        tmux new-session -ds $selected_name -c $selected

        tmux new-window -t $selected_name:2 -c $selected
        tmux new-window -t "$selected_name:3" -n lazygit -c "$selected" lazygit
        tmux new-window -t $selected_name:4 -c $selected

    end

    if test -n "$TMUX"
        tmux switch-client -t $selected_name
    else
        tmux attach-session -t $selected_name
    end
end
