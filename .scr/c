#!/usr/bin/env zsh

cmd="g++ -Wall -g -lm -o"
res="./now"
case $# in
    0)
        cmd=$cmd" now _.cc"
        ;;
    1)
        cmd=$cmd" now $1"
        ;;
    *)
        if [[ ${2:0:1} ==  "-" ]]; then
            cmd=$cmd" now $1"
        else
            cmd=$cmd" $2 $1"
            res="./$2"
            shift
        fi
        shift
        until [[ $# == 0 ]]; do
            cmd=$cmd" $1"
            shift
        done
        ;;
esac
eval $cmd
if [[ $? == 0 ]]; then
    echo -e "\e[32mRuning Result...\e[0m\n"
    eval $res
else
    echo -e "\n\e[41mCompile Failed...\e[0m\n"
fi

