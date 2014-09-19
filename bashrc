#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Original prompt
#PS1='[\u@\h \W]\$ '

#Bash prompt
PS1="\[\e[0m\]» \[\e[1;31m\]\u\[\e[0m\] » [\[\e[1;31m\]\W\[\e[0m\]]\[\e[1;31m\]:\[\e[0m\] "

#Uncomment if vi keybindings wanted -> WARNING: mandatory esc keybind annoying
#set -o vi

# Accessibility
alias sch='cd ~/Documents/School'
alias cs233='cd ~/Documents/School/CS233/dlxu2'
alias cs241='cd ~/Documents/School/CS241/dlxu2'
alias doc='cd ~/Documents'
alias pro='cd ~/Documents/Programming'
alias db='cd ~/Dropbox'
alias dbs='python ~/Dropbox/dropbox.py start'
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
alias sshdogevnc='ssh daniel@130.126.63.181 -L 8900/localhost/5901'  #VNC usage
alias pacs='sudo pacman -S'
alias sag='sudo apt-get install'
alias aptupdate='sudo apt-get update && sudo apt-get dist-upgrade'
alias sshdoge='ssh daniel@130.126.62.47'
alias ls='ls --color=auto'
alias printjobs='firefox localhost:631/printers/HP_DeskJet_930C'
#Clarity
alias calc='bc -l'
