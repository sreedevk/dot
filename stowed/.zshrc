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

# XDG DIRECTORIES
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Media/music"
export XDG_PICTURES_DIR="$HOME/Media/images"
export XDG_VIDEOS_DIR="$HOME/Media/videos"

# BETTER TERM
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export TERM=xterm-256color
export TERMINFO=/usr/share/terminfo/
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8

# TIMEZONE
export TZ='America/New_York'

# HISTORYFILE
HISTSIZE=100
SAVEHIST=100

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
setopt PROMPT_SUBST
setopt AUTOCD
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt interactivecomments

# Set VI mode
set -o vi

# KEY BINDINGS
bindkey -s '^o' 'lfcd\n'
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line
bindkey '^R' history-incremental-search-backward
bindkey '^[[Z' autosuggest-accept

if [ -f "$(command -v fastfetch)" ]; then
  echo "\n"
  fastfetch
  echo "\n"
fi
