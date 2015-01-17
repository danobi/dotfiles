#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Original prompt
#PS1='[\u@\h \W]\$ '

# Bash prompt
PS1="\[\e[0m\]» \[\e[1;31m\]\u\[\e[0m\] » [\[\e[1;31m\]\W\[\e[0m\]]\[\e[1;31m\]:\[\e[0m\] "

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	    . /usr/share/bash-completion/bash_completion

# History size
HISTFILESIZE=10000

#Uncomment if vi keybindings wanted -> WARNING: mandatory esc keybind annoying
#set -o vi

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
alias ls='ls --color=auto'
# Clarity
alias calc='bc -l'
# Useful
export TERM=xterm-256color # colorized vim
# PATHS
export PATH=/home/dan/Development/Eclipse_adt_bundle/android-ndk-r10c:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
