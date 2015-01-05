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

# Autocompletion of package names
# And alias for apt-get
alias sag='sudo apt-get install'
__apt_install_completion()
{
	# copied out of /usr/share/bash-completion/completions/apt-get:_apt_get()
	# Get information about completion
	local cur prev words cword
	_init_completion || return

	 Generate list of matching packages
	 COMPREPLY=( $( apt-cache --no-generate pkgnames "$cur" \
		 2> /dev/null ) )
	 return 0
} &&
complete -F __apt_install_completion sag

# History size
HISTFILESIZE=10000

#Uncomment if vi keybindings wanted -> WARNING: mandatory esc keybind annoying
#set -o vi

# Accessibility
alias sch='cd ~/Documents/School'
alias cs233='cd ~/Documents/School/CS233/dlxu2'
alias cs241='cd ~/Documents/School/CS241/dlxu2'
alias doc='cd ~/Documents'
alias cod='cd ~/Documents/Coding'
alias db='cd ~/Dropbox'
alias dbs='python ~/Dropbox/dropbox.py start'
alias dwmc='cd ~/Documents/Computer_Config/dwm/dwm-6.0'
alias ..='cd ..'
# Safety nets
alias mv='mv -i'
alias cp='cp -i'
# Shorterners
alias sco='xset dpms force off'
alias lk='xscreensaver-command --lock'
alias hib='sudo pm-hibernate'
alias sus='sudo pm-suspend'
alias la='ls -a'
alias c='clear'
alias pacs='sudo pacman -S'
alias sag='sudo apt-get install'
alias aptupdate='sudo apt-get update && sudo apt-get dist-upgrade'
alias ls='ls --color=auto'
alias printjobs='firefox localhost:631/printers/HP_DeskJet_930C'
# Clarity
alias calc='bc -l'
# Useful
export PAGER="most"   # colorized man pages
export TERM=xterm-256color # colorized vim for example
# PATHS
export PATH=/home/dan/Development/Eclipse_adt_bundle/android-ndk-r10c:$PATH
