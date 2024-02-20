#!/bin/env sh

cd "$DOTFILES/.config"
for dir in *
do
    rm -v "$XDG_CONFIG_HOME/$dir"
done

rm -v "$HOME/.zshenv" "$HOME/.xinitrc"
