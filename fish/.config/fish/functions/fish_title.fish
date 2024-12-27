function fish_title
    # Set title to something more descriptive if tmux is detected
    set -l command (status current-command)
    if test "$command" = tmux
        echo "[tmux] $hostname"
    else
        echo (status current-commandline)
    end
end
