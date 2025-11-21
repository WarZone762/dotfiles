#!/bin/env sh

add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

export M2_2="/m2.2"
export SSD1="/ssd1"
export SSD2="/ssd2"
export CUSTOM_HOME="$M2_2/user"
export DOTFILES="$HOME/dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CURRENT_DESKTOP="i3"
export QT_QPA_PLATFORMTHEME=gtk2

export SHELL="/bin/zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

export ZDOTDIR="$DOTFILES/zsh"

add_to_path $HOME/.cargo/bin
add_to_path $DOTFILES/bin
add_to_path $CUSTOM_HOME/bin
add_to_path $CUSTOM_HOME/opt/bin
