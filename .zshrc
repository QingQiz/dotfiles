export LANG='en_US.UTF-8'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='most'
export TERM='termite'
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME=/usr/lib/jvm/java-10-openjdk
export PATH=$PATH:/home/angel/.scr
export PATH=$PATH:$HOME/.dotnet/tools
# export PATH=$PATH:$HOME/.stack/programs/x86_64-linux/ghc-tinfo6-8.8.3/bin
export MANPAGER=cat
export PAGER=less
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
export fpath=( "$HOME/.zsh/zfunctions" $fpath )

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/z/z.plugin.zsh


#turn on comments with # in shell
setopt interactivecomments


if [[ $DISPLAY ]]; then
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
    [[ $XDG_VTNR == 1 ]] && exec startx
fi

# ls color
eval "$( dircolors ~/.colorrc )"
export LC_CTYPE=zh_CN.UTF-8

# command correct
eval $( thefuck --alias )

##=======================================================================
# alias

alias ggpush='git push origin master'
alias gst='git status'
alias gcl='git clone'
alias gdf='git diff'
alias gcam='git commit -am'

# alias l='ls++'
# alias ll='ls++ --potsf -a'
alias la='ls -a'
alias lh="du -ahd1 | sort -h"
alias t='tmux'
alias tks='tmux kill-session -t'
alias f='feh'
alias ff='ffmpeg'
alias vi='vim'
# alias ec='emacsclient -nw'
alias ec='emacsclient -c -n'
alias vs='vim -u ~/.vimrc_simple --noplugin'
alias vims='vim --noplugin -u NONE'
alias cls='clear'
alias py='python3'
alias py2='python2'
alias ipy='ipython'
alias sx='startx'
alias prename='perl-rename'
alias p='ping bilibili.com'
alias pscp='psshscp'
alias ch='chromium'
alias vbox='virtualbox'
alias nc='ncat'

alias zsh='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias i3rc='vim ~/.config/i3/config'
alias vimrc='vim ~/.vimrc'
alias pipi='sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple'
alias aria2='aria2c --conf-path=/home/angel/.config/aria2/aria2.conf'

alias sqlserver='sudo /opt/mssql/bin/sqlservr'

alias g='/home/angel/workspace/you-get/you-get'
alias gs='/home/angel/workspace/you-get/you-get -s 127.0.0.1:1080'

alias sl='ls'

##-----------------------------------------------------------------------




##=======================================================================
# commonly used functions
command_not_found_handler() {
    local pkgs cmd="$1"
    typeset -l lcmd
    lcmd=$cmd

    if [[ $(command -v $lcmd) ]]; then
        shift
        [[ `alias $lcmd` ]] && lcmd=${${$(alias $lcmd)#$lcmd=\'}%\'}
        eval "sudo "$lcmd $@
        return $?
    fi

    pkgs=(${(f)"$(pkgfile -b -v -- "$lcmd" 2>/dev/null)"})
    if [[ -n "$pkgs" ]]; then
        printf '%s may be found in the following packages:\n' "$lcmd"
        printf '  %s\n' $pkgs[@]
        return 0
    fi

    printf 'zsh: command not found: %s\n' "$cmd" 1>&2
    return 127
}

# conda() {
#    [[ `echo $PATH | grep 'conda'` ]] || source /opt/anaconda/bin/activate
#    \conda $@
#}

qb() {
    qutebrowser --target tab $@
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
    ip a | grep `ip r | head -n 1 | awk '{print $3}'` | grep inet | awk '{print $2}'
}

lanip6() {
    ip a | grep inet6 | grep global | awk '{print $2}' | cut -d\/ -f1
}

# ycm() {
    # if ! [ -f '.ycm_extra_conf.py' ]; then
        # cp ~/.config/ycmd/ycmd_conf.py .ycm_extra_conf.py
    # fi
# }

mv2hd() {
    mv "$1" '/media/sdb1/document/files/'
}

save2hd() {
    dir="/media/sdb1/Arch/"
    if [ -d $dir$1 ] || [ -f $dir$1 ]; then
        echo 'file exists'
        return
    fi
    mv $1 $dir
    ln -s $dir"$1" "`pwd`/$1"
}

saveback() {
    if [ -f '/media/sdb1/Arch/'"$1" ] || [ -d '/media/sdb1/Arch/'"$1" ]
    then
        rm -f "$1"
        mv '/media/sdb1/Arch/'"$1" "$1"
    fi
}

ver() {
    iverilog -o now $@
    if [[ $? == 0 ]]; then
        echo -e "\e[32mRuning Result...\e[0m\n"
        ./now
        rm -f now
    else
        echo -e "\n\e[41mCompile Failed...\e[0m\n"
    fi
}

rmv() {
    mv $2 $1
}

function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi
        local proxy=$1
        export http_proxy="$proxy" \
               https_proxy=$proxy \
               ftp_proxy=$proxy \
               rsync_proxy=$proxy
        echo "Proxy environment variable set."
        return 0
    fi

    echo -n "username: "; read username
    if [[ $username != "" ]]; then
        echo -n "password: "
        read -es password
        local pre="$username:$password@"
    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    local proxy=$pre$server:$port
    export http_proxy="$proxy" \
           https_proxy=$proxy \
           ftp_proxy=$proxy \
           rsync_proxy=$proxy \
           HTTP_PROXY=$proxy \
           HTTPS_PROXY=$proxy \
           FTP_PROXY=$proxy \
           RSYNC_PROXY=$proxy
}

function proxy_off(){
    unset http_proxy https_proxy ftp_proxy rsync_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY
    echo -e "Proxy environment variable removed."
}



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

