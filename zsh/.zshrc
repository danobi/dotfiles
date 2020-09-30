# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# It looks in ~/.oh-my-zsh/themes/ followed by ~/.oh-my-zsh/custom/themes/
ZSH_THEME="dxu"

# Disables the auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(dirhistory sudo colored-man-pages)

# User configuration
export PATH="$HOME/bin:$PATH"
export PATH="/opt/ctags/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/bin:$PATH"
source $ZSH/oh-my-zsh.sh

# This makes the colored-man-pages oh-my-zsh plugin work (no one knows why)
export GROFF_NO_SGR=1

# Do not save command lines into history if they are a repeat of the previous
setopt HIST_IGNORE_DUPS

# Makes `sudoedit` work
export EDITOR="vim"

# Turn off the ridiculous auto cd feature
unsetopt AUTO_CD

# Zephyr toolchain config
[[ -f "$HOME/.zephyrrc" ]] && source ~/.zephyrrc

# Helper to colorize .diff files
function cless() {
  colordiff < "$1" | less
}

# ix.io helper
ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
	case $x in
	    h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
	    d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
	    i) opts="$opts -X PUT"; local id="$OPTARG";;
	    n) opts="$opts -F read:1=$OPTARG";;
	esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
	local filename="$1"
	shift
	[ "$filename" ] && {
	    curl $opts -F f:1=@"$filename" $* ix.io/$id
	    return
	}
	echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

# github PR helper
ghpr() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Usage: ghpr PR_NUM BRANCH_NAME"
        return 1
    fi;

    local target_branch="pr_${2}"
    git fetch upstream "pull/${1}/head:${target_branch}" || return 1
    echo "Fetched PR #${1} to ${target_branch}"
}

# Aliases
alias mv='mv -i'
alias cp='cp -i'
alias la='ls -a'
alias c='clear'
alias sdi='sudo dnf install'
alias sag='sudo apt-get install'
alias pacs='sudo pacman -S'
alias ls='ls --color=auto'
alias e='exit'
alias tmux="TERM=screen-256color tmux"
alias cl="clear && ls"
alias o="gio open"
alias calc='bc -l'
alias se='sudoedit'
alias f='find . -name'
alias r='ranger'
alias vimd='vim -d'
alias cds='clipd -p | xclip -sel c'

# Git stuff
alias gdh="gd HEAD"
alias gmf="git merge --ff-only"
alias gr="git rebase"
alias gri="git rebase -i"
