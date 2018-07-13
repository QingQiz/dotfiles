#!/bin/bash

s=$(echo $(synclient | grep -i touchpadoff) | sed -e 's/^.*\(.\)$/\1/g')

let s=$s^1

synclient TouchpadOff=$s
