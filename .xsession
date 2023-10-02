#!/bin/env sh

export QT_QPA_PLATFORMTHEME=qt5ct

xset r rate 200 60
xinput --set-prop "Logitech G102 LIGHTSYNC Gaming Mouse" "libinput Accel Profile Enabled" 0, 1
setxkbmap -layout us,ru -option grp:shift_caps_toggle

xsetroot -solid "#333333"
