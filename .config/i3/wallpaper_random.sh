#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

path=~/Pictures/WallP
cd $path

files=()
for i in *.jpg; do
    [[ -f $i ]] && files+=("$i")
done
range=${#files[@]}

chc=$RANDOM
chc=$(($chc % $range))

feh --bg-fill ${files[$chc]}

echo $chc > $script_dir/.nowpap
