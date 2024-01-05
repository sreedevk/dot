# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# LOADS ZSH PROFILER
## zmodload zsh/zprof

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
export TERMINFO=/usr/share/terminfo/
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8

if [ -z "$TMUX" ]; then
    export TERM=xterm-256color
fi

# TIMEZONE
export TZ='America/New_York'

# HISTORYFILE
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export HISTFILE=~/.cache/zsh/history
export HISTSIZE=1000
export SAVEHIST=1000

# NON INTERACTIVE MODE EARLY RETURN
[[ $- != *i* ]] && return

zle -N edit-command-line

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/plugin-opts.sh" ]  && source ~/.zsh/plugin-opts.sh
[ ! -f "$HOME/.zsh/plugins.sh" ]    && antibody bundle < ~/.zsh/plugins > ~/.zsh/plugins.sh
[ -f "$HOME/.zsh/plugins.sh" ]      && source ~/.zsh/plugins.sh

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases.sh" ]   && source "$HOME/.zsh/aliases.sh"
[ -f "$HOME/.zsh/functions.sh" ] && source "$HOME/.zsh/functions.sh"
[ -f "$HOME/.zsh/autoloads.sh" ] && source "$HOME/.zsh/autoloads.sh"

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line

# ZSH OPTS
setopt COMPLETE_ALIASES
setopt PROMPT_SUBST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt interactivecomments
setopt extendedglob
setopt autocd
setopt nomatch
setopt notify
setopt sharehistory
setopt appendhistory
unsetopt beep

# Set VI mode
set -o vi

# KEY BINDINGS
bindkey -s '^o' 'lfcd\n'
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line
bindkey '^[[Z' autosuggest-accept

if [ -f "$(command -v fastfetch)" ]; then
  echo "\n"
  fastfetch
  echo "\n"
fi
