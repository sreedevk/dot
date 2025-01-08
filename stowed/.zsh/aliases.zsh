#!/usr/bin/zsh

# TITLE: ZSH (Z Shell) Aliases
# AUTHOR: Sreedev Kodichath

# Sys
alias la='/usr/bin/ls'
alias ls='eza --color=always --long --all --header --icons --git'
alias lsa='eza --color=always --long --all --sort=age --reverse --header --icons'
alias ll='eza -l --icons --color=always'
alias lla='eza -la --icons --color=always'
alias twee='eza -aT --color=always --group-directories-first'
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
alias zxi='__zoxide_zi'
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

# Tmuxinator - Tmux Session Manager
alias mux='tmuxinator'
alias t="tmux"
alias ta="tmux a"
alias ts="tmux-sessionizer"
alias zl="zellij"

# git
alias g='git'
alias gg='jj'

# Docker
alias dk='docker compose'
alias d='docker'

# yt-dlp
alias yt='yt-dlp'
