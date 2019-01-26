istty=$( tty | grep tty )

export TERM='termite'
export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:/home/angel/.scr

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/z/z.plugin.zsh
source ~/.oh-my-zsh/plugins/extract/extract.plugin.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fpath=( "$HOME/.zsh/zfunctions" $fpath )

#turn on comments with # in shell
setopt interactivecomments

### EXPORTS
export LANG='en_US.UTF-8'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='most'

if [[ $istty == "" ]]; then
    export POWERLINE_CONFIG_COMMAND='powerline-config'

    autoload -U zmv
    autoload -U promptinit; promptinit
    source ~/.zsh/zfunctions/pure

    export QT_SELECT=4
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx
    HISTSIZE=2147483647
else
    export PS1="[%n@ %d]$ "
fi

export LC_CTYPE=zh_CN.UTF-8

##=======================================================================
# alias

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
alias ec='emacsclient -c -n'
alias vs='vim -u ~/.vimrc_simple --noplugin'
alias sv='vim -u ~/.vimrc_simple --noplugin'
alias vims='vim --noplugin -u NONE'
alias cls='clear'
alias py='python3'
alias sx='startx'
alias scd='cd'
alias sduo='sudo'
alias suod='sudo'
alias prename='perl-rename'
alias p='ping qq.com'
alias pscp='psshscp'

alias zsh='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias i3rc='vim ~/.config/i3/config'
alias vimrc='vim ~/.vimrc'
alias pipi='sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple'
alias aria2='aria2c --conf-path=/home/angel/.config/aria2/aria2.conf'
alias ruijie='ruijie i once'

alias nip='curl -i https://ip.cn'

alias ColorCoded='cp ~/.config/color_coded/.color_coded .'
alias YcmExtra='cp ~/.config/ycmd/ycmd_conf.py .'
alias AddCMakeList='cp ~/workspace/Progeaming-Practice/Note/CMakeLists.txt .'


##-----------------------------------------------------------------------




##=======================================================================
# commonly used functions

c() {
    cmd="g++ -Wall -g -lm -o"
    res="./now"
    case $# in
        0)
            cmd=$cmd" now _.cc"
            ;;
        1)
            cmd=$cmd" now $1"
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


ssh() {
    trap 'export TERM=termite; trap 2; return' 2
    TERM='xterm'
    /usr/bin/ssh $@
    TERM='termite'
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
dupkg() {
    expac '%m\t%n' | sort -h | awk '{cmd = "numfmt --to=si "$1; cmd | getline n; close(cmd); print n, $2}'
}
dupkg_ex() {
    expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n
}

lhs() {
    for list in $(ls -a | sed 's/\ /\\ /g'); do
        du -hs $list;
    done | sort -hr
}

lanip() {
    ip a | grep $(ip r | grep default | head | cut -d\  -f5) | grep inet | awk '{print $2}' | cut -d"/" -f1
}

bak() { cp "$1" "$1.bak" }
bakm() { mv "$1" "$1.bak" }


##-----------------------------------------------------------------------




##=======================================================================
# tab completion for some functions

compdef '_files -g "*.cc"' c
compdef '_files -g "*.cc"' pushmod
compdef '_files -g "*.cc"' pushcode
compdef '_files -g "*.vcd"' gtkwave
compdef '_files -g "*.v"' ver
compdef _nothing lh
compdef _nothing lhs
compdef _nothing dupkg
compdef _nothing dupkg_ex


##-----------------------------------------------------------------------
