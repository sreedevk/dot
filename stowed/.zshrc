# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# LOADS ZSH PROFILER
## zmodload zsh/zprof

# PATHS
LOCAL_BIN_PATH="$HOME/.local/bin"
LOCAL_BIN_SUB_PATH="$HOME/.local/bin/**/*"
export GOPATH="$HOME/go"
export PATH="$PATH:$LOCAL_BIN_PATH:$LOCAL_BIN_SUB_PATH:$GOPATH/bin/"

# ENV VARIABLES
export VISUAL="nvim"
export EDITOR=nvim
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

# BEAM CURSOR
echo -ne '\e[5 q'

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line

zle -N edit-command-line

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases" ]   && source "$HOME/.zsh/aliases"
[ -f "$HOME/.zsh/functions" ] && source "$HOME/.zsh/functions"
[ -f "$HOME/.zsh/autoloads" ] && source "$HOME/.zsh/autoloads"
[ -f "$HOME/.zsh/fzf" ]       && source "$HOME/.zsh/fzf"
[ -f "$HOME/.zsh/vi" ]       && source "$HOME/.zsh/vi"

# ZSH OPTS
setopt PROMPT_SUBST
setopt interactivecomments

# KEY BINDINGS
bindkey -s '^o' 'lfcd\n'
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line

# REVERSE SEARCH (ENABLE IF ATUIN IS NOT INSTALLED)
# bindkey '^R' history-incremental-search-backward

# ANTIBODY COMPILE ZSH
# antibody bundle < ~/.zsh/plugins > ~/.zsh/plugins.sh

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/plugins.sh" ] && source ~/.zsh/plugins.sh

# FIX COLOR SCHEME ISSUES IN SYNTAX HIGHLIGHTING
ZSH_HIGHLIGHT_STYLES[comment]='none'

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0403c58
  \e]P1ea6f91
  \e]P29bced7
  \e]P3f1ca93
  \e]P434738e
  \e]P5c3a5e6
  \e]P6eabbb9
  \e]P7faebd7
  \e]P86f6e85
  \e]P9ea6f91
  \e]PA9bced7
  \e]PBf1ca93
  \e]PC34738e
  \e]PDc3a5e6
  \e]PEeabbb9
  \e]PFffffff
  "
  # get rid of artifacts
  clear
fi

if [ -f "$(command -v fastfetch)" ]; then
  echo "\n"
  fastfetch
  echo "\n"
fi

