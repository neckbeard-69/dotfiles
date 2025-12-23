function git-clean
    if test (count $argv) -ne 1
        echo "Usage: git-clean <branch>"
        return 1
    end

    set branch $argv[1]

    echo "This will reset the current branch to origin/$branch"
    echo "ALL local changes, commits, and untracked files will be deleted."
    echo -n "Are you sure? (y/N) "
    read confirm

    switch $confirm
        case y Y yes YES
            echo "Proceeding..."
        case '*'
            echo "Aborted."
            return 1
    end

    echo "Fetching from origin..."
    git fetch origin

    echo "Hard resetting to origin/$branch..."
    git reset --hard origin/$branch

    echo "Cleaning untracked files and dirs..."
    git clean -fd

    echo "Done. Local branch now matches origin/$branch exactly."
end
