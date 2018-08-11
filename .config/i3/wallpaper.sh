#!/usr/bin/env bash

path=~/Pictures/WallP
cd $path

files=()
for i in *.jpg; do
    [[ -f $i ]] && files+=("$i")
done
range=${#files[@]}

feh --bg-fill ${files[$RANDOM % $range]}
