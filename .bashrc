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
    cmd="g++ -Wall -g -lm -o"
    res="./now"
    case $# in
        0)
            cmd=$cmd"now _.cc"
            ;;
        1)
            cmd=$cmd"now $1"
            ;;
        *)
            if [[ ${2:0:1} ==  "-" ]]; then
                cmd=$cmd" now $1"
            else
                cmd=$cmd" $2 $1"
                res="./$2"
                shift
            fi
            shift
            until [[ $# == 0 ]]; do
                cmd=$cmd" $1"
                shift
            done
            ;;
    esac
    eval $cmd
    if [[ $? == 0 ]]; then
        echo -e "\e[32mRuning Result...\e[0m\n"
        eval $res
    else
        echo -e "\n\e[41mCompile Failed...\e[0m\n"
    fi
}

ver() {
    iverilog -o now $1 $2
    if [[ $? == 0 ]]; then
        echo -e "\e[32mRuning Result...\e[0m\n"
        echo "finish" | ./now
        rm -f now
    else
        echo -e "\n\e[41mCompile Failed...\e[0m\n"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

