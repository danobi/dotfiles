# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# It looks in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# Disables the auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git dirhistory sudo autojump colored-man-pages)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:~/.local/bin:/opt/ctags/bin:/home/daniel/.local/bin"
export GOPATH=$HOME/dev/gobook
export TERM=screen-256color
source $ZSH/oh-my-zsh.sh

# This makes the colored-man-pages oh-my-zsh plugin work (no one knows why)
export GROFF_NO_SGR=1

# Aliases
alias sch='cd ~/Documents/School'
alias doc='cd ~/Documents'
alias cod='cd ~/Documents/Coding'
alias db='cd ~/Dropbox'
alias mv='mv -i'
alias cp='cp -i'
alias hib='sudo pm-hibernate'
alias sus='sudo pm-suspend'
alias la='ls -a'
alias c='clear'
alias sdi='sudo dnf install'
alias sag='sudo apt-get install'
alias aptupdate='sudo apt-get update && sudo apt-get dist-upgrade'
alias pacs='sudo pacman -S'
alias ls='ls --color=auto'
alias e='exit'
alias tmux="TERM=screen-256color tmux"
alias cl="clear && ls"
alias o="xdg-open"
alias calc='bc -l'

# Git stuff
alias gdh="gd HEAD"
