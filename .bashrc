#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '


c() {
    if [[ $# == 0 ]]; then
        g++ -Wall -o now _.cc -g -lm && ./now
    else
        g++ -Wall -o now $1 -g -lm && ./now
    fi
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cls='clear'
alias l='ls'
alias s='ls'
alias sl='ls'
alias la='ls -a'
alias scd='cd'
