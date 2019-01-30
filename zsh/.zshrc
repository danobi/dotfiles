# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# It looks in ~/.oh-my-zsh/themes/ followed by ~/.oh-my-zsh/custom/themes/
ZSH_THEME="dxu"

# Disables the auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git dirhistory sudo autojump colored-man-pages)

# User configuration
export PATH="$HOME/bin:$PATH"
export PATH="/opt/ctags/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/bin:$PATH"
export TERM=screen-256color
source $ZSH/oh-my-zsh.sh

# This makes the colored-man-pages oh-my-zsh plugin work (no one knows why)
export GROFF_NO_SGR=1

# Do not save command lines into history if they are a repeat of the previous
setopt HIST_IGNORE_DUPS

# Makes `sudoedit` work
export EDITOR="vim"

# Source dt wrapper script
source ~/dev/dt/dt.sh

# Turn off the ridiculous auto cd feature
unsetopt AUTO_CD

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
alias vim='echo "use nvim" && $(exit 1)'

# Git stuff
alias gdh="gd HEAD"
alias gmf="git merge --ff-only"
