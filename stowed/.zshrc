# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export CARGO_BIN_PATH="$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin:/opt/bin:$CARGO_BIN_PATH"

# XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# ENV VARIABLES
export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="brave"
export DOTFILES="$HOME/.dot"

# BETTER TERM
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export TERMINFO="/usr/share/terminfo/"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG="en_US.UTF-8"
export TZ='America/New_York'
export WORDCHARS=${WORDCHARS/\/}
export CLICOLOR=1

if [ -z "$TMUX" ]; then
    export TERM="xterm-256color"
fi

# HISTORYFILE
export HISTORY_IGNORE="(ls|cd|pwd|exit|history)"
export HISTFILE=$HOME/.cache/zsh/history
export HISTFILESIZE=10000
export HISTSIZE=1000
export SAVEHIST=1000
export HISTCONTROL=erasedups:ignoredups:ignorespace

# NON INTERACTIVE MODE EARLY RETURN
[[ $- != *i* ]] && return

zle -N edit-command-line

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/zinit.zsh" ]  && source "$HOME/.zsh/zinit.zsh"

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases.zsh" ]   && source "$HOME/.zsh/aliases.zsh"
[ -f "$HOME/.zsh/functions.zsh" ] && source "$HOME/.zsh/functions.zsh"
[ -f "$HOME/.zsh/autoloads.zsh" ] && source "$HOME/.zsh/autoloads.zsh"

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line

[ -f "$HOME/.zsh/post-compinit.zsh" ] && source "$HOME/.zsh/post-compinit.zsh"

# ZSH OPTS
setopt   COMPLETE_ALIASES
setopt   PROMPT_SUBST
setopt   HIST_IGNORE_ALL_DUPS
setopt   HIST_FIND_NO_DUPS
setopt   HIST_IGNORE_SPACE
setopt   HIST_REDUCE_BLANKS 
setopt   HIST_SAVE_NO_DUPS
setopt   interactivecomments
setopt   extendedglob
setopt   autocd
setopt   nomatch
setopt   notify
setopt   sharehistory
setopt   appendhistory
unsetopt beep

# Set VI mode
set -o vi

# KEY BINDINGS
bindkey -s    '^xo'    'ycd\n'
bindkey       '^R'    fzf-history-widget
bindkey       '^A'    beginning-of-line
bindkey       '^E'    end-of-line
bindkey       '^xn'    edit-command-line
bindkey       '^xh'   _complete_help
bindkey       '^[[Z'  autosuggest-accept
bindkey -a -r ':'

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  (echo -e "\n"; eval "$(command -v fastfetch)"; echo -e "\n")
fi
