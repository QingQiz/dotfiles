#!/bin/bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

install_c() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "installing $1..."
        sudo pacman -S $1
    fi
}
install_n() {
    sudo pacman -S $1 --needed
}

install_q() {
    echo "install $1(y/n)"
    read chc
    if [[ $chc == 'y' ]]; then
        if [[ $# == 1 ]]; then
            install_n $1
            return
        fi
        shift
        until [[ $# == 0 ]]; do
            install_n $1
            shift
        done
    fi
}
ln_() {
    if [ -d "$HOME/$1" ] || [ -f "$HOME/$1" ]; then
        if ! [ -L "$HOME/$1" ]; then
            mv "$HOME/$1" $script_dir/backup/$1
        else
            rm "$HOME/$1"
        fi
    fi
    ln -s $script_dir/$1 $HOME/$1
}
ln_c() {
    if [ -d "$HOME/.config/$1" ] || [ -f "$HOME/.config/$1" ]; then
        if ! [ -L "$HOME/.config/$1" ]; then
            mv "$HOME/.config/$1" $script_dir/backup/.config/$1
        else
            rm "$HOME/.config/$1"
        fi
    fi
    ln -s "$script_dir/.config/$1" "$HOME/.config/"
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
if ! [ -d "$script_dir/backup" ]; then
    mkdir "$script_dir/backup"
    if ! [ -d "$script_dir/backup/.config" ]; then
        mkdir "$script_dir/backup/.config"
    fi
fi
install_c yaourt
install_c make
install_c cmake
install_c git
install_c gcc
install_c g++
install_c clang
ln_ .gitconfig
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
    )
echo "config vim? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo "configing vim..."
    if ! [ -d "$script_dir/.vim/vimfiles" ]; then
        mkdir $script_dir/.vim/vimfiles
    fi
    cd $script_dir/.vim/vimfiles/

    echo "installint gvim & some plugins..."
    for gg in ${plugin_list1[@]}
    do
        install_n $gg
    done
    echo "installing plugins..."
    for gg in ${plugin_list2[@]}
    do
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
                if ! [ -d "$PWD/build" ]; then
                    mkdir build
                fi
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

    ln_ .vim
    ln_ .vimrc
fi
#--------------------------------------------------
# zsh
#--------------------------------------------------
echo "install zsh? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo "installing zsh..."
    install_c zsh
    if [ $SHELL != "/bin/zsh" ]; then
        chsh -s /bin/zsh
    fi

    echo "configing..."
    install_n zsh-syntax-highlighting
    cd $script_dir/
    git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
    if ! [ -d "$script_dir/.zsh" ]; then
        mkdir $script_dir/.zsh
        mkdir $script_dir/.zsh/zfunctions
    elif ! [ -d "$script_dir/.zsh/zfunctions" ]; then
        mkdir $script_dir/.zsh/zfunctions
    fi
    cd $script_dir/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    git clone https://github.com/sindresorhus/pure.git

    ln -sf "$script_dir/.zsh/pure/pure.zsh" zfunctions/pure
    ln -sf "$script_dir/.zsh/pure/async.zsh" zfunctions/async

    ln_ .oh-my-zsh
    ln_ .bashrc
    ln_ .zsh
    ln_ .zshrc
fi
#--------------------------------------------------
# i3-gap
#--------------------------------------------------
echo "install i3? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    echo 'installing...'
    ln -sf $script_dir/.Xresources $script_dir/.Xdefaults
    install_n xorg-server
    install_n xorg-xinit
    install_n i3-gaps
    install_c tmux
    install_c compton
    install_c polybar
    install_c rofi
    install_c neofetch
    install_c termite
    # install_c terminator
    install_c thunar
    install_n ttf-font-awesome
    install_n awesome-terminal-fonts
    install_n powerline-fonts
    install_n noto-fonts
    install_n noto-fonts-cjk
    install_n noto-fonts-emoji


    ln_ .asoundrc
    ln_ .compton
    ln_ .Xauthority
    ln_ .Xdefaults
    ln_ .xinitrc
    ln_ .Xmodmap
    ln_ .xprofile
    ln_ .Xresources
    ln_ .Xresources.d
    ln_ .tmux.conf

    ln_c i3
    ln_c neofetch
    ln_c polybar
    ln_c rofi
    ln_c Thunar
    ln_c termite
    # ln_c terminator

    cd $script_dir
    git clone https://github.com/powerline/fonts.git
    cd fonts
    sh install.sh
    fc-catch -fv
    cd ..
    rm fonts -rf
fi
#--------------------------------------------------
# emacs
#--------------------------------------------------
echo "install emacs? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    cd $script_dir
    install_c emacs
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    ln_ .spacemacs

fi
#--------------------------------------------------
# others
#--------------------------------------------------
echo "others(y/n)"
read chc
if [ "$chc" == "y" ]; then
    echo "install aria2? (y/n)"
    read chc
    if [ "$chc" = "y" ]; then
        install_c aria2-fast
        ln_c aria2
        touch .config/aria2/aria2.session
    fi

    echo "install shadowsock? (y/n)"
    read chc
    if [[ $chc == "y" ]]; then
        sudo pacman -S shadowsocks shadowsocks-libev
    fi
    echo "install mpd? (y/n)"
    read chc
    if [ "$chc" = "y" ]; then
        install_c mpd
        install_c mpc
        ln_ .mpd
    fi
    # 远程桌面
    install_q remmian
fi
