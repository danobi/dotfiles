# github PR helper
function ghpr
    # Check if two arguments are provided
    if test (count $argv) -ne 2
        echo "Usage: ghpr PR_NUM BRANCH_NAME"
        return 1
    end

    # Determine the remote to use
    set remote upstream
    if not git remote get-url upstream > /dev/null 2>&1
        set remote origin
    end

    # Set the target branch name
    set target_branch "pr_$argv[2]"

    # Fetch the PR
    if not git fetch $remote "pull/$argv[1]/head:$target_branch"
        return 1
    end

    echo "Fetched PR #$argv[1] to $target_branch"
end
