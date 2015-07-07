#
# ~/.bashrc
#
# Accessibility
alias sch='cd ~/Documents/School'
alias doc='cd ~/Documents'
alias cod='cd ~/Documents/Coding'
alias db='cd ~/Dropbox'
alias ..='cd ..'
# Safety nets
alias mv='mv -i'
alias cp='cp -i'
alias vim='nvim'
# Shorterners
alias hib='sudo pm-hibernate'
alias sus='sudo pm-suspend'
alias la='ls -a'
alias c='clear'
alias sag='sudo apt-get install'
alias aptupdate='sudo apt-get update && sudo apt-get dist-upgrade'
#alias ls='ls --color=auto'
# Clarity
alias calc='bc -l'
# Useful
export TERM=xterm-256color # colorized vim
alias tmux='tmux -2' # force tmux to assume 256 color support for terminal
# PATHS
export PATH=/home/dan/Development/Eclipse_adt_bundle/android-ndk-r10c:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
