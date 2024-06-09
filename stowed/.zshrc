# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export PATH="$PATH:$HOME/.local/bin:/opt/bin"

# ENV VARIABLES
export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="brave"

# BETTER TERM
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export TERMINFO="/usr/share/terminfo/"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG="en_US.UTF-8"
export TZ='America/New_York'
export WORDCHARS=${WORDCHARS/\/}

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
[ -f "$HOME/.zsh/zinit.sh" ]  && source "$HOME/.zsh/zinit.sh"

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases.sh" ]   && source "$HOME/.zsh/aliases.sh"
[ -f "$HOME/.zsh/functions.sh" ] && source "$HOME/.zsh/functions.sh"
[ -f "$HOME/.zsh/autoloads.sh" ] && source "$HOME/.zsh/autoloads.sh"

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line

# ZSH OPTS
setopt   COMPLETE_ALIASES
setopt   PROMPT_SUBST
setopt   HIST_IGNORE_ALL_DUPS
setopt   HIST_FIND_NO_DUPS
setopt   HIST_IGNORE_SPACE
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
bindkey -s '^o'    'lfcd\n'
bindkey    '^R'    fzf-history-widget
bindkey    '^A'    beginning-of-line
bindkey    '^E'    end-of-line
bindkey    '^x'    edit-command-line
bindkey    '^[[Z'  autosuggest-accept

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  (echo -e "\n"; eval "$(command -v fastfetch)"; echo -e "\n")
fi
