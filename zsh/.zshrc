# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# User configuration
source_if_exists() {
    [[ ! -f "$1" ]] || source "$1"
}

tmux-ses() {
    local name=$(tmuxinator list --newline | tail -n+2 | fzf)
    [[ ! "$name" ]] && return 1
    tmuxinator ${1:-start} "$name" && exit
}

tmux-exit() {
    tmuxinator stop $(tmux display-message -p "#S")
}

export HISTFILE="$DOTFILES/.histfile"

unsetopt beep

if command eza &> /dev/null
then
    alias ls="eza --icons=always"
else
    alias ls="ls --color=auto"
fi
alias grep="grep --color=auto"

source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source_if_exists /usr/share/fzf/key-bindings.zsh
source_if_exists /usr/share/fzf/completion.zsh
# End of user configuration

eval "$(starship init zsh)"
