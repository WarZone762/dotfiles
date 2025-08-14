#!/bin/env sh

export QT_QPA_PLATFORMTHEME=gtk2

xset r rate 200 60
setxkbmap -layout us,ru -option grp:shift_caps_toggle

xsetroot -solid "#11111b"
