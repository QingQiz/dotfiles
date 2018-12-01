#!/usr/bin/zsh

if [[ `cat "$HOME/.cache/brightness"` == "" ]]; then
    rm -f "$HOME/.cache/brightness"
fi

if ! [ -f "$HOME/.cache/brightness" ]; then
    touch "$HOME/.cache/brightness"
    echo "1" > $HOME/.cache/brightness
fi

bts=`cat $HOME/.cache/brightness`

case $# in
    1)
        if [[ ${1:0:1} == '-' ]] || [[ ${1:0:1} == '+' ]]; then
            nxt=$(($bts$1))
            if python -c "import sys; sys.exit(0 if 0 <= float($nxt) <= 1 else 1)"; then
                bts=$nxt
            fi
        fi
        ;;
    *)
        ;;
esac

xrandr --output eDP-1 --brightness $bts

echo $bts > $HOME/.cache/brightness
