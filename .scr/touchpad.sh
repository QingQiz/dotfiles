#!/bin/bash

s=$(echo $(synclient | grep -i touchpadoff) | sed -e 's/^.*\(.\)$/\1/g')

if [ $s == 1 ]; then
    s=0
else
    s=1
fi

synclient TouchpadOff=$s
