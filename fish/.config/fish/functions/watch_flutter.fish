function watch_flutter
    if not set -q argv[1]
        echo "Error: No path provided."
        return 1
    end

    set -l target_path $argv[1]
    set -l device_id $argv[2]
    set -l device_flag ""

    if test -n "$device_id"
        set device_flag "-d $device_id"
        echo "📱 Targeting device: $device_id"
    else
        echo "🖥️  No device specified, using default target..."
    end

    # Create named pipe safely
    set -l pipe_path (mktemp -u /tmp/flutter_pipe_XXXXXX)
    mkfifo $pipe_path

    echo "🚀 Starting Flutter..."
    sh -c "tail -f $pipe_path | flutter run $device_flag" &
    set -l flutter_pid $last_pid

    # --- RELOAD watcher (safe changes) ---
    watchexec -n -e dart \
        -w $target_path \
        --ignore $target_path/lib/main.dart \
        --postpone \
        -- sh -c "echo r > $pipe_path" &
    set -l reload_pid $last_pid

    # --- RESTART watcher (critical changes) ---
    watchexec -n \
        -w $target_path/lib/main.dart \
        -w $target_path/pubspec.yaml \
        -w $target_path/android \
        -w $target_path/ios \
        --postpone \
        -- sh -c "echo R > $pipe_path" &
    set -l restart_pid $last_pid

    function _cleanup_flutter \
        --on-variable EXIT_TRIGGER \
        --inherit-variable flutter_pid \
        --inherit-variable reload_pid \
        --inherit-variable restart_pid \
        --inherit-variable pipe_path \
        --inherit-variable target_path

        echo -e "\n🧹 Cleaning up..."

        # Kill watchers
        test -n "$reload_pid"; and kill $reload_pid 2>/dev/null
        test -n "$restart_pid"; and kill $restart_pid 2>/dev/null

        # Kill flutter process and children
        if test -n "$flutter_pid"
            pkill -P $flutter_pid 2>/dev/null
            kill $flutter_pid 2>/dev/null
        end

        # Safety cleanup
        pkill -f "flutter_tool.*$target_path" 2>/dev/null

        # Remove pipe
        test -p $pipe_path; and rm $pipe_path

        echo "✅ Stopped."
    end

    echo --------------------------------------------------
    echo "🚀 FLUTTER SMART WATCHER"
    echo "Auto: reload (r) / restart (R)"
    echo "Manual: [R]estart, [q]uit"
    echo --------------------------------------------------

    # Manual input loop
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
