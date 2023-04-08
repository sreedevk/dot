# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# LOADS ZSH PROFILER
## zmodload zsh/zprof

# PATHS
export PATH="$PATH:$HOME/.local/bin"

# ENV VARIABLES
export VISUAL="nvim"
export EDITOR="nvim"
export READER="zathura"
export TERMINAL="kitty"
export BROWSER="brave"

# BETTER TERM
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export TERM=xterm-256color
export TERMINFO=/usr/share/terminfo/
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8

# HISTORYFILE
HISTSIZE=100
SAVEHIST=100

# NON INTERACTIVE MODE EARLY RETURN
[[ $- != *i* ]] && return

zle -N edit-command-line

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases" ]   && source "$HOME/.zsh/aliases"
[ -f "$HOME/.zsh/functions" ] && source "$HOME/.zsh/functions"
[ -f "$HOME/.zsh/autoloads" ] && source "$HOME/.zsh/autoloads"
[ -f "$HOME/.zsh/fzf" ]       && source "$HOME/.zsh/fzf"

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line

# ZSH OPTS
setopt PROMPT_SUBST
setopt interactivecomments

# KEY BINDINGS
bindkey -s '^o' 'lfcd\n'
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line
bindkey '^R' history-incremental-search-backward

# ANTIBODY COMPILE ZSH
# antibody bundle < ~/.zsh/plugins > ~/.zsh/plugins.sh

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/plugins.sh" ] && source ~/.zsh/plugins.sh

# FIX COLOR SCHEME ISSUES IN SYNTAX HIGHLIGHTING
ZSH_HIGHLIGHT_STYLES[comment]='none'

if [ -f "$(command -v fastfetch)" ]; then
  echo "\n"
  fastfetch
  echo "\n"
fi
