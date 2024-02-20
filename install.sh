#!/bin/env sh

cd "$DOTFILES/.config"
for dir in *
do
    ln -svT "$DOTFILES/.config/$dir" "$XDG_CONFIG_HOME/$dir"
done

ln -svT "$DOTFILES/.profile" "$HOME/.zshenv"
ln -svT "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
