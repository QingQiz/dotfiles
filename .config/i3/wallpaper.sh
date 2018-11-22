#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

path=~/Pictures/WallP
cd $path

files=()
for i in ./*.{jpg,png}; do
    [[ -f $i ]] && files+=("$i")
done
range=${#files[@]}

chc=$(cat $script_dir/.nowpap)
[[ $chc == "" ]] && chc=0

if [[ $# == 0 ]]; then
    chc=$(($chc + 1))
else
    chc=$(($chc + $1))
fi
chc=$(($chc % $range))

feh --bg-fill ${files[$chc]}

echo $chc > $script_dir/.nowpap
