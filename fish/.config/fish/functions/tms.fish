function tms
    if test (count $argv) -gt 0
        set paths $argv
    else
        set paths ~/Desktop/code
    end

    if type -q fd
        set selected_path (fd . $paths --min-depth 1 --max-depth 1 --type d | fzf)
    else
        set selected_path (find $paths -mindepth 1 -maxdepth 1 -type d | fzf)
    end

    if test -z "$selected_path"
        return 0
    end

    set session_name (basename "$selected_path" | string replace -a '.' '_')

    # If we're outside Zellij
    if test -z "$ZELLIJ_PANE_PID"
        cd "$selected_path"
        # Attach or create session
        zellij attach "$session_name" -c
        return 0
    end

    zellij action new-pane
    zellij action write-chars "cd '$selected_path'" 
    zellij action write 10
end
