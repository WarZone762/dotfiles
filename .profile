#!/bin/env sh

add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

export HDD1="/hdd1"
export CUSTOM_HOME="$HDD1/user"
export DOTFILES="$HOME/dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"

export SHELL="/bin/zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

export ZDOTDIR="$DOTFILES/zsh"

add_to_path $HOME/.cargo/bin
add_to_path $DOTFILES/bin
add_to_path $CUSTOM_HOME/bin
add_to_path $CUSTOM_HOME/opt/bin
