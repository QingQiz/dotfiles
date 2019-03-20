#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

install_n() {
    until [[ $# == 0 ]]; do
        sudo pacman -S $1 --needed --noconfirm
        shift
    done
}
ln_() {
    until [[ $# == 0 ]]; do
        if [ -d "$HOME/$1" ] || [ -f "$HOME/$1" ]; then
            if ! [ -L "$HOME/$1" ]; then
                mv "$HOME/$1" $script_dir/backup/$1
            else
                rm "$HOME/$1"
            fi
        fi
        ln -s $script_dir/$1 $HOME/$1
        shift
    done
}
ln_c() {
    until [[ $# == 0 ]]; do
        if [ -d "$HOME/.config/$1" ] || [ -f "$HOME/.config/$1" ]; then
            if ! [ -L "$HOME/.config/$1" ]; then
                mv "$HOME/.config/$1" $script_dir/backup/.config/$1
            else
                rm "$HOME/.config/$1"
            fi
        fi
        ln -s "$script_dir/.config/$1" "$HOME/.config/"
        shift
    done
}
install_q() {
    flg=0
    for xx in $*; do
        if [[ $xx == '-d' ]]; then
            flg=1
            continue
        fi
        if [[ $flg == 1 ]]; then
            echo "install $xx(y/n)?"
            break
        fi
    done
    [[ $flg == 0 ]] && return
    read chc
    if [[ $chc == 'y' ]]; then
        until [[ $# == 0 ]]; do
            case ${1:0:1} in
                '-')
                    case ${1:1:2} in
                        'd') shift ;;
                        'e')
                            shift
                            eval $1
                            ;;
                    esac
                    ;;
                '+') install_n ${1:1} ;;
            esac
            shift
        done
    fi
}
#--------------------------------------------------
# needed
#--------------------------------------------------
echo "recover mirrorlist? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    sudo mv /etc/pacman.conf /etc/pacman.conf.bak
    sudo cp $script_dir/archlinux/mirrorlist /etc/pacman.d/
    sudo cp $script_dir/archlinux/pacman.conf /etc/
    sudo pacman -Syy
fi
mkdir -p "$script_dir/backup/.config"
install_n yaourt make cmake git gcc g++ clang
ln_ .gitconfig .scr
#--------------------------------------------------
# vim
#--------------------------------------------------
plugin_list1=(\
    "gvim" \
    "vim-molokai" \
    "vim-surround" \
    "vim-tagbar" \
    "vim-nerdtree" \
    "vim-airline" \
    "vim-airline-themes" \
    "vim-ultisnips" \
    )
plugin_list2=(\
    "mhinz/vim-startify" \
    "Yggdroot/indentLine" \
    "jiangmiao/auto-pairs" \
    "kshenoy/vim-signature" \
    "guns/xterm-color-table.vim" \
    "luochen1990/rainbow" \
    "mbbill/undotree" \
    "easymotion/vim-easymotion" \
    "junegunn/vim-easy-align" \
    "lilydjwg/fcitx.vim.git"\
    )
echo "config vim? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo "configing vim..."
    mkdir -p $script_dir/.vim/vimfiles
    cd $script_dir/.vim/vimfiles/

    echo "installint gvim & some plugins..."
    for gg in ${plugin_list1[@]}; do
        install_n $gg
    done
    echo "installing plugins..."
    for gg in ${plugin_list2[@]}; do
        echo "cloning "$gg"..."
        git clone "https://github.com/"$gg".git"
    done

    echo "install color_coded? (y/n)"
    read chc
    if [ "$chc" = "y" ]; then
        cd $script_dir/.vim/vimfiles
        if ! [ -d "color_coded" ]; then
            git clone "https://github.com/jeaye/color_coded.git"
            cd $script_dir/.vim/vimfiles/color_coded
            rm -f CMakeCache.txt
            if ! [ -f "color_coded.so" ]; then
                mkdir -p build
                cd build
                cmake .. -DDOWNLOAD_CLANG=0
                make -j && make install
                make clean
            fi
        fi
        ln -sf $script_dir/.vim/syntax/color_coded.vim $script_dir/.vim/vimfiles/color_coded/after/syntax/color_coded.vim
        ln_c color_coded
    fi

    echo "install YouCompleteMe? (y/n)"
    read chc
    if [ "$chc" = "y" ]; then
        cd $script_dir/.vim/vimfiles
        if ! [ -d "YouCompleteMe" ]; then
            git clone "https://github.com/Valloric/YouCompleteMe.git"
            cd $script_dir/.vim/vimfiles/YouCompleteMe
            git submodule update --init --recursive
            ./install.py --clang-completer
            ln_c ycmd
        fi
    fi

    ln_ .vim .vimrc
fi
#--------------------------------------------------
# zsh
#--------------------------------------------------
echo "install zsh? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo "installing zsh..."
    install_n zsh
    if [ $SHELL != "/bin/zsh" ]; then
        chsh -s /bin/zsh
    fi

    echo "configing..."
    install_n zsh-syntax-highlighting
    cd $script_dir/
    git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
    mkdir -p $script_dir/.zsh/zfunctions
    cd $script_dir/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    git clone https://github.com/sindresorhus/pure.git

    ln -sf "$script_dir/.zsh/pure/pure.zsh" zfunctions/pure
    ln -sf "$script_dir/.zsh/pure/async.zsh" zfunctions/async

    ln_ .oh-my-zsh .bashrc .zsh .zshrc
    
fi
#--------------------------------------------------
# i3-gap
#--------------------------------------------------
echo "install i3? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo 'installing...'
    ln -sf $script_dir/.Xresources $script_dir/.Xdefaults
    install_n xorg-server xorg-xinit i3-gaps tmux compton polybar rofi neofetch w3m termite feh thunar ttf-font-awesome awesome-terminal-fonts powerline-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji numlockx
    ln_ .asoundrc .compton .Xauthority .Xdefaults .xinitrc .Xmodmap .xprofile .Xresources .Xresources.d .tmux.conf .colorrc .conky
    ln_c i3 neofetch polybar rofi Thunar termite

    cd $script_dir
    git clone https://github.com/powerline/fonts.git
    cd fonts
    sh install.sh
    fc-catch -fv
    cd ..
    rm fonts -rf

    cd $script_dir
    card=`ls /sys/class/backlight/`
    for xx in $card; do
        card=$xx
        break
    done
    cd archlinux
    sudo sed -e "s/XXX/$card/g" backlight.service > /usr/lib/systemd/system/backlight.service
    sudo systemctl start backlight.service
    sudo systemctl enable backlight.service
fi
#--------------------------------------------------
# emacs
#--------------------------------------------------
install_q \
    -d "emacs(baced on spacemacs)" +"emacs" \
    -e "cd $script_dir && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d" \
    -e "ln_ .spacemacs"
#--------------------------------------------------
# others
#--------------------------------------------------
echo "install some applications(y/n)?"
read chc
if [ "$chc" == "y" ]; then
    install_q -d aria2 +"aria2-fast"\
        -e "ln_c aria2" \
        -e "touch .config/aria2/aria2.session" 

    install_q -d "shadowsock" +"shadowsocks" +"shadowsocks-libev"
    install_q -d "mpd" +"mpd" +"mpc" \
        -e "ln_ .mpd"
    install_q -d "remmian" +"remmian"
    install_q -d "wireshark" +"wireshark"
    install_q -d "create_ap" +"create_ap"
    install_q -d "zbar (read and create qrcode)" +"zbar"
fi
