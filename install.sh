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
ln_() {
    if [ -d "$HOME/$1" ]; then
        # mv "$HOME/.config/$1" "$script_dir/backup"
        rm -rf "$HOME/$1"
    fi
    ln -sf $script_dir/$1 $HOME/$1
}
ln_c() {
    if [ -d "$HOME/.config/$1" ]; then
        # mv "$HOME/.config/$1" "$script_dir/backup"
        rm -rf "$HOME/.config/$1"
    fi
    ln -s "$script_dir/.config/$1" "$HOME/.config/"
}
#--------------------------------------------------
# needed
#--------------------------------------------------
echo "recover mirrorlist? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    sudo cp $script_dir/archlinux/mirrirlist /etc/pacman.d/
    sudo cp $script_dir/archlinux/pacman.config /etc/
    sudo pacman -Syy
fi
install_c yaourt
install_c make
install_c cmake
install_c git
install_c gcc
install_c g++
install_c clang
install_n llvm
ln_ .gitconfig
# if ! [ -d "$script_dir/backup" ]; then
    # mkdir "$script_dir/backup"
# fi
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
    "Yggdroot/indentLine" \
    "jiangmiao/auto-pairs" \
    "kshenoy/vim-signature" \
    "guns/xterm-color-table.vim" \
    "luochen1990/rainbow" \
    "mbbill/undotree" \
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
        git clone "https://github.com/jeaye/color_coded.git"
        cd $script_dir/.vim/vimfiles/color_coded
        rm -f CMakeCache.txt
        if ! [ -d "$PWD/build" ]; then
            mkdir build 
        fi
        cd build
        cmake .. -DDOWNLOAD_CLANG=0
        make -j && make install
        make clean
        ln -s $script_dir/.vim/syntax/color_coded.vim $script_dir/.vim/vimfiles/color_coded/after/syntax/color_coded.vim
        ln_c color_coded
    fi

    echo "install YouCompleteMe? (y/n)"
    read chc
    if [ "$chc" = "y" ]; then
        cd $script_dir/.vim/vimfiles
        git clone "https://github.com/Valloric/YouCompleteMe.git"
        cd $script_dir/.vim/vimfiles/YouCompleteMe
        git submodule update --init --recursive
        ./install.py --clang-completer
        ln_c ycmd
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
    sudo chsh -s /bin/zsh

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
    install_c compton
    install_c polybar
    install_c rofi
    install_c neofetch
    install_c termite
    install_c terminator
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
    ln_ .i3

    ln_c neofetch
    ln_c polybar
    ln_c rofi
    ln_c Thunar
    ln_c termite
    ln_c terminator
fi
#--------------------------------------------------
# emacs
#--------------------------------------------------
#--------------------------------------------------
# others
#--------------------------------------------------
echo "install aria2? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    install_c aria2-fast
    ln_c aria2
fi
echo "install mpd? (y/n)"
read chc
if [ "$chc" = "y" ]; then
    install_c mpd
    install_c mpc
    ln_ .mpd
fi
