#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Accessibility
alias sch='cd ~/Documents/School'
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
alias la='ls -a'
alias c='clear'
alias sshdogevnc='ssh 130.126.63.181 -L 8900/localhost/5901'  #VNC usage
alias sshdoge='ssh 130.126.63.181'
#Clarity
alias calc='bc -l'
