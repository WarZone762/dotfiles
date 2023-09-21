# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit "$ZDOTDIR/.p10k.zsh".
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"

# User configuration

source_if_exists() {
    [[ ! -f "$1" ]] || source "$1"
}

alias tmux="tmux -f $TMUX_CONFIG"
if command eza &> /dev/null
then
    alias ls="eza --icons"
else
    alias ls="ls --color=auto"
fi
alias grep="grep --color=auto"

source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source_if_exists /usr/share/fzf/key-bindings.zsh
source_if_exists /usr/share/fzf/completion.zsh
# End of user configuration
