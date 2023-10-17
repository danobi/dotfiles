if status is-interactive
  # Disable prompt suggestions
  set -g fish_autosuggestion_enabled 0

  # Disable greeting when shell is started
  set -U fish_greeting

  # Disable argv[0] highlighting
  set -U fish_color_command

  # Disable underlining valid filepaths
  set -U fish_color_valid_path

  # Set default editor
  set -Ux EDITOR vim

  # If you don't set the LESS env var, git defaults it to LESS=FRX
  # which does annoying stuff like auto-exit if the entire file fits
  # on the screen. So keep it simple and only get colorized output.
  set -Ux LESS R

  # Configure $PATH
  fish_add_path $HOME/bin
  fish_add_path $HOME/.local/bin
  fish_add_path $HOME/.cargo/bin

  # pastes.dxuuu.xyz helper
  function pastes
    if test -t 0
        echo "^C to cancel, ^D to send"
    end
    curl https://pastes.dxuuu.xyz --data-binary '@-'
  end

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

  # Aliases
  abbr --add mv mv -i
  abbr --add cp cp -i
  abbr --add la ls -a
  abbr --add pacs sudo pacman -S
  abbr --add ll ls -l
  abbr --add e exit
  abbr --add o "gio open"

  # Git aliases
  abbr --add gb git branch
  abbr --add gc git commit
  abbr --add gd git diff
  abbr --add gdh git diff HEAD
  abbr --add gds git diff --staged
  abbr --add gmf git merge --ff-only
  abbr --add gr git rebase
  abbr --add gri git rebase -i
  abbr --add grc git rebase --continue
  abbr --add gcp git cherry-pick
  abbr --add gcpc git cherry-pick --continue
  abbr --add gco git checkout
  abbr --add gst git status
  abbr --add ga git add
  abbr --add gf git fetch
  abbr --add gfa git fetch --all
  abbr --add gs git switch
end
