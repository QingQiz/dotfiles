#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '



alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


dupkg() {
    expac '%m\t%n' | sort -h | awk '{cmd = "numfmt --to=si "$1; cmd | getline n; close(cmd); print n, $2}'
}
dupkg_ex() {
    expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n
}

lhs() {
    for list in $(ls -a | sed 's/\ /\\ /g'); do du -hs $list; done | sort -hr
}

bak() {
    cp "$1" "$1.bak"
}
bakm() {
    mv "$1" "$1.bak"
}


alias ggpush='git push origin master'
alias gst='git status'
alias gcl='git clone'
alias gdf='git diff'
alias gcam='git commit -am'

alias l='ls'
alias s='ls'
alias ll='ls -al'
alias la='ls -a'
alias sl='ls'
alias sls='ls'
alias lh="du -ahd1 | sort -h"
alias t='tmux'
alias tks='tmux kill-session -t'
alias f='feh'
alias v='vim'
alias vu='vim'
alias vo='vim'
alias vi='vim'
alias vs='vim -u ~/.vimrc_simple --noplugin'
alias sv='vim -u ~/.vimrc_simple --noplugin'
alias cls='clear'
alias py='python3'
alias sx='startx'
alias scd='cd'
alias prename='perl-rename'
alias p='ping qq.com'

alias zsh='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias i3rc='vim ~/.config/i3/config'
alias vimrc='vim ~/.vimrc'
alias pipi='sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple'
alias aria2='aria2c --conf-path=/home/angel/.config/aria2/aria2.conf'
alias ruijie='ruijie i once'

alias nip='curl -i https://ip.cn'
alias sofee='sudo netctl start wlo1-Sofeeys'

alias ColorCoded='cp ~/.config/color_coded/.color_coded .'
alias YcmExtra='cp ~/.config/ycmd/ycmd_conf.py .'
alias AddCMakeList='cp ~/workspace/Progeaming-Practice/Note/CMakeLists.txt .'

c() {
    if [[ $# == 0 ]]; then
        g++ -Wall -o now _.cc -g -lm && ./now
    elif [[ $# == 1 ]]; then
        g++ -Wall -o now $1 -g -lm && ./now
    elif [[ $# == 2 ]]; then
        g++ -Wall -o now $1 -g -lm $2 && ./now
    fi
}
 
pushmod() {
    if [[ $# == 1 ]]; then
        cp ./_.cc ~/workspace/Progeaming-Practice/ACM-ICPC/Mod/$1
    else
        cp ./$1 ~/workspace/Progeaming-Practice/ACM-ICPC/Mod/$2
    fi
}

pushcode() {
    if [[ $# == 1 ]]; then
        cp ./_.cc ~/workspace/Progeaming-Practice/ACM-ICPC/CodeHub/$1
    else
        cp ./$1 ~/workspace/Progeaming-Practice/ACM-ICPC/CodeHub/$2
    fi
}
