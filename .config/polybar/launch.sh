#!/usr/bin/env sh

killall -q polybar

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
done
