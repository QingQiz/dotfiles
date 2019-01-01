#!/usr/bin/env bash

xrandr --output DP-2 --right-of eDP-1 --auto
xrandr --output eDP-1 --primary

sleep 1

i3 restart
