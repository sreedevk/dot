# TITLE: Bash (Bourne-Again Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export CARGO_BIN_PATH="$HOME/.cargo/bin"
export GHCUP_BIN_PATH="$HOME/.ghcup/bin"
export LOCAL_BIN_PATH="$HOME/.local/bin"
export OPT_BIN_PATH="/opt/bin"
export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"

export PATH="$PATH:$LOCAL_BIN_PATH:$OPT_BIN_PATH:$CARGO_BIN_PATH:$GHCUP_BIN_PATH"

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

# VIM BINDINGS
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-a: beginning-of-line'
bind -m vi-insert 'Control-e: end-of-line'
bind -m vi-insert 'Control-k: previous-history'
bind -m vi-insert 'Control-j: next-history'
bind -m vi-insert 'Control-w: backward-word'

# SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# MISE AUTOLOADS
if [ -f "$(command -v mise)" ]; then
  eval "$(mise activate bash)"
fi

# DIRENV AUTOLOADS
if [ -f "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

# STARSHIP AUTOLOADS
if [ -f "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi

# ZOXIDE AUTOLOADS
if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init bash)"
fi

# CARGO AUTOLOADS
if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

# RADICLE AUTOLOADS
if [ -d "$HOME/.radicle/bin" ]; then
  export PATH="$PATH:$HOME/.radicle/bin"
fi

# ALIASES
alias la='eza --color=always --all --header --icons --git'
alias ls='eza --color=always --header'
alias ll='eza -l --icons --long --color=always'
alias lla='eza -la --icons --long --all --color=always'
alias lt='eza --tree --level=2 --long --icons --git'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias obliterate='shred -zvu -n 5'
alias xo='xdg-open'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias jctl="journalctl -p 3 -xb"
alias clock="tty-clock -csSbt -C3"
alias wget="noglob wget"
alias curl="noglob curl"
alias z='__zoxide_z'
alias zz='__zoxide_zi'
alias cw='cliphist --wipe'

# Taskwarrior
alias tt="taskwarrior-tui"
alias to="taskopen"
alias tl="task list"

# Safe Opts
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -iv"

alias e="$EDITOR"
alias n="nvim"

# Tmuxinator - Tmux Session Manager
alias mux='tmuxinator'
alias t="tmux new -A -s system"
alias ta="tmux a"
alias ts="tmux-sessionizer"
alias zl="zellij"

# git
alias g='git'
alias gg='jj'

# Docker
alias dc='docker compose'
alias d='docker'

# yt-dlp
alias yt='yt-dlp'

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  echo && eval "$(command -v fastfetch)" && echo
fi
