# Theme configuration
source "${HOME}/.theme.zsh"

# User configuration
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export MAKEFLAGS="--no-print-directory"
export FZF_DEFAULT_COMMAND="fd --type f --hidden"
export EDITOR="vim"

# Allow parameter expansion, command subst, arith in PROMPT expansion
setopt PROMPT_SUBST

# Turn off the ridiculous auto cd feature
unsetopt AUTO_CD

# Configure shell history
HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=999999
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
bindkey '^R' history-incremental-search-backward

# Configure completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Use emacs-style line editor bindings
bindkey -e

# pastes.dxuuu.xyz helper
pastes() {
  [ -t 0 ] && echo "^C to cancel, ^D to send"
  curl https://pastes.dxuuu.xyz --data-binary '@-'
}

# github PR helper
ghpr() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: ghpr PR_NUM BRANCH_NAME"
        return 1
    fi;

    local remote=upstream
    if ! git remote get-url upstream &> /dev/null; then
      remote=origin
    fi

    local target_branch="pr_${2}"
    git fetch "$remote" "pull/${1}/head:${target_branch}" || return 1
    echo "Fetched PR #${1} to ${target_branch}"
}

# Aliases
alias mv='mv -i'
alias cp='cp -i'
alias la='ls -a'
alias sdi='sudo dnf install'
alias sag='sudo apt-get install'
alias pacs='sudo pacman -S'
alias ls='ls --color=auto'
alias ll='ls -l'
alias e='exit'
alias tmux="TERM=screen-256color tmux"
alias o="gio open"

# Git stuff
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gdh="git diff HEAD"
alias gds="git diff --staged"
alias gmf="git merge --ff-only"
alias gr="git rebase"
alias gri="git rebase -i"
alias grc="git rebase --continue"
alias gcp="git cherry-pick"
alias gcpc="git cherry-pick --continue"
alias gco="git checkout"
alias gst="git status"
alias ga="git add"
alias gf="git fetch"
alias gfa="git fetch --all"
alias gs="git switch"
