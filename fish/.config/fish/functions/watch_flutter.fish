function watch_flutter
    if not set -q argv[1]
        echo "Error: No path provided."
        return 1
    end

    set -l target_path $argv[1]
    set -l device_id $argv[2] # Optional second argument
    set -l device_flag ""

    if test -n "$device_id"
        set device_flag "-d $device_id"
        echo "📱 Targeting device: $device_id"
    else
        echo "🖥️  No device specified, using default target..."
    end

    set -l pipe_path (mktemp -u /tmp/flutter_pipe_XXXXXX)
    mkfifo $pipe_path

    # Start the background pipeline
    # We use 'exec' inside sh to make PID tracking more reliable
    sh -c "tail -f $pipe_path | flutter run $device_flag" &
    set -l flutter_pid $last_pid

    watchexec -n -e dart -w $target_path --postpone -- sh -c "echo r > $pipe_path" &
    set -l watcher_pid $last_pid

    function _cleanup_flutter --on-variable EXIT_TRIGGER --inherit-variable flutter_pid --inherit-variable watcher_pid --inherit-variable pipe_path
        echo -e "\nCleaning up processes..."

        # Kill the specific background processes
        test -n "$watcher_pid"; and kill $watcher_pid 2>/dev/null
        # Kill the flutter run process and ALL its children (the actual app)
        if test -n "$flutter_pid"
            pkill -P $flutter_pid 2>/dev/null # Kill children
            kill $flutter_pid 2>/dev/null # Kill parent
        end

        # Safety: kill any orphaned flutter/dart processes associated with this folder
        pkill -f "flutter_tool.*$target_path" 2>/dev/null

        test -p $pipe_path; and rm $pipe_path
        echo "Stopped."
    end

    echo --------------------------------------------------
    echo "🚀 FLUTTER INTERACTIVE WATCHER"
    echo "Commands: [R]estart, [q]uit"
    echo --------------------------------------------------

    while read -l -p "" input
        switch $input
            case R
                echo R >$pipe_path
            case q
                echo q >$pipe_path
                set EXIT_TRIGGER 1
                break
        end
    end

    set -g EXIT_TRIGGER 1
end
