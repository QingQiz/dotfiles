#!/usr/bin/env bash

s=$(echo $(synclient | grep -i tapbutton1) | sed -e 's/^.*\(.\)$/\1/g')

if [ $s = 0 ]; then
    synclient TapButton1=1
    synclient TapButton2=3
    synclient TapButton3=2
else
    synclient TapButton1=0
    synclient TapButton2=1
    synclient TapButton3=3
fi

