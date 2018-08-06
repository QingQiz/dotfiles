# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux
# if [[ -z "$TMUX" ]] ;then
    # ID="`tmux ls | grep -m1 attached | cut -d: -f1`"
    # if [[ -z "$ID" ]] ;then
        # tmux new-session
    # else
        # tmux attach-session -t "$ID"
    # fi
# fi

#turn on comments with # in shell
setopt interactivecomments

### EXPORTS
export LANG='en_US.UTF-8'
export EDITOR='vim'
export VISUAL='vim'
export BROWSER='google-chrome-stable'
export POWERLINE_CONFIG_COMMAND='powerline-config'
export PAGER='most'
export PATH=${PATH}:~/.gem/ruby/2.4.0/bin


### ARCHLINUX INCLUDE
dupkg() { expac '%m\t%n' | sort -h | awk '{cmd = "numfmt --to=si "$1; cmd | getline n; close(cmd); print n, $2}' }
dupkg_ex() { expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n }
### ZSHRC NODE
# source ~/.zshrc_node

### ZSH PURE
autoload -U zmv
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/z/z.plugin.zsh
source ~/.oh-my-zsh/plugins/extract/extract.plugin.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fpath=( "$HOME/.zsh/zfunctions" $fpath )
autoload -U promptinit; promptinit
# prompt pure
source ~/.zsh/zfunctions/pure

plugins=(
        git 
        extract
        python 
        colored-man-pages 
        colorize 
        sprunge 
        web-search
        )

### ALIASES

alias zshconfig_node="vi ~/.zshrc_node"
alias sshconfig="vi ~/.ssh/config"

alias lh="du -ahd1 | sort -h"
# lhs() { for list in $(ls -a | sed 's/\ /\\ /g'); do du -hs $list; done | sort -hr }

wanip() { curl icanhazip.com }
lanip() { ip a | grep $(ip r | grep default | head | cut -d\  -f5) | grep inet | awk '{print $2}' | cut -d"/" -f1 }

alias ix="curl -s -F 'f:1=<-' ix.io"

bak() { cp "$1" "$1.bak" }
bakm() { mv "$1" "$1.bak" }


HISTSIZE=2147483647
export QT_SELECT=4
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

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
alias rm='trash'
alias t='tmux'
alias tks='tmux kill-session -t'
alias f='feh'
alias v='vim'
alias vu='vim'
alias vo='vim'
alias vi='vim'
alias svi='vim -u ~/temp/SpaceVim/init.vim' # use SpaceVim
alias svim='vim -u ~/temp/SpaceVim/init.vim' # use SpaceVim
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

alias WAcCEpTEd='netctl start wlp2s0-WAcCEpTEd'
alias CHANGAN='netctl start wlp2s0-NWPU-CHANGAN'

alias nip='curl -i https://ip.cn'

alias ColorCoded='cp ~/.config/color_coded/.color_coded .'
alias YcmExtra='cp ~/.config/ycmd/.ycm_extra_conf.py .'
alias AddCMakeList='cp ~/workspace/Progeaming-Practice/Note/CMakeLists.txt .'

push() { cp ./"$1" ~/workspace/this_week/$1 }
Done() { cp _.cc ./"$1" }
DoneinJava() { cp ~/workspace/java-workspace/ACM/src/Main.java ./"$1" }
pushmod() { cp ./$1 ~/workspace/Progeaming-Practice/ACM-ICPC/Mod/$2 }
