if status is-interactive
  # Disable prompt suggestions
  set -g fish_autosuggestion_enabled 0

  # Disable greeting when shell is started
  set -U fish_greeting

  # Disable argv[0] highlighting
  set -U fish_color_command

  # Disable underlining valid filepaths
  set -U fish_color_valid_path

  # Aliases
  abbr --add mv mv -i
  abbr --add cp cp -i
  abbr --add la ls -a
  abbr --add pacs sudo pacman -S
  abbr --add ll ls -l
  abbr --add e exit
  abbr --add tmux "TERM screen-256color tmux"
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
