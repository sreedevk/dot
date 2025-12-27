#!/usr/bin/zsh

# TITLE: ZSH (Z Shell) Aliases
# AUTHOR: Sreedev Kodichath

# Sys
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
alias tl="tasklite"

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
