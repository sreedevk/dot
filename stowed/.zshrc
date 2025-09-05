# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export CARGO_BIN_PATH="$HOME/.cargo/bin"
export GHCUP_BIN_PATH="$HOME/.ghcup/bin"
export LOCAL_BIN_PATH="$HOME/.local/bin"
export OPT_BIN_PATH="/opt/bin"
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

export PATH="$PATH:$LOCAL_BIN_PATH:$OPT_BIN_PATH:$CARGO_BIN_PATH:$GHCUP_BIN_PATH"

# XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# ENV VARIABLES
export VISUAL="nvim"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="brave"
export DOTFILES="$HOME/.dot"

# BETTER TERM
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export TERMINFO="/usr/share/terminfo/"
export MANROFFOPT="-c"
export MANPAGER="nvim +Man!"
export MANPATH="$HOME/.nix-profile/share/man:/usr/share/man:/usr/local/share/man:${MANPATH}"
export LANG="en_US.UTF-8"
export TZ='America/New_York'
export WORDCHARS=${WORDCHARS/\/}
export CLICOLOR=1

if [ -z "$TMUX" ]; then
    export TERM="xterm-256color"
fi

# HISTORYFILE
export HISTORY_IGNORE="(ls|cd|pwd|exit|history)"
export HISTFILE=$HOME/.cache/zhistory
export HISTFILESIZE=10000
export HISTSIZE=1000
export SAVEHIST=1000
export HISTCONTROL=erasedups:ignoredups:ignorespace

zle -N edit-command-line

# NON INTERACTIVE MODE EARLY RETURN
[[ $- != *i* ]] && return

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/zinit.zsh" ]  && source "$HOME/.zsh/zinit.zsh"

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases.zsh" ]   && source "$HOME/.zsh/aliases.zsh"
[ -f "$HOME/.zsh/functions.zsh" ] && source "$HOME/.zsh/functions.zsh"
[ -f "$HOME/.zsh/autoloads.zsh" ] && source "$HOME/.zsh/autoloads.zsh"

# AUTOLOAD MODULES
zmodload     zsh/complist 
autoload -U  colors && colors
autoload -U  promptinit && promptinit
autoload -U  compinit && compinit -u
autoload -Uz bashcompinit && bashcompinit
autoload     edit-command-line

_comp_options+=(globdots)

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
setopt   globdots
setopt   autocd
setopt   nomatch
setopt   notify
setopt   sharehistory
setopt   appendhistory
setopt   incappendhistory
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

# NOTE: fixes the issue where kitty terminal exiting neovim after 
# overseer nvim is launched, puts the zsh prompt at "execute:3u"
bindkey -a -r ':'

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  (echo -e "\n"; eval "$(command -v fastfetch)"; echo -e "\n")
fi
