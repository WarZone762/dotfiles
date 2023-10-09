#!/bin/env sh

add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

export DRIVE1="/hdd1"
export CUSTOM_HOME="$DRIVE1/user"
export DOTFILES="$HOME/dotfiles"

export SHELL="/bin/zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export HISTFILE="$DOTFILES/.histfile"

export ZDOTDIR="$DOTFILES/zsh"
export TMUX_CONFIG="$DOTFILES/.tmux.conf"
export NVIM_CONFIG="$DOTFILES/nvim"
export VIMINIT="source $NVIM_CONFIG/init.lua"
export GIT_CONFIG_GLOBAL="$DOTFILES/.gitconfig"

export I3_CONFIG="$DOTFILES/i3/config"
export I3STATUS_CONFIG="$DOTFILES/i3status/config"
export ROFI_CONFIG="$DOTFILES/rofi/config.rasi"
export WEZTERM_CONFIG_FILE="$DOTFILES/.wezterm.lua"

add_to_path $HOME/.cargo/bin
add_to_path $DOTFILES/bin
add_to_path $CUSTOM_HOME/bin
add_to_path $CUSTOM_HOME/opt/bin
