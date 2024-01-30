# TITLE: ZSH (Z Shell) Aliases
# AUTHOR: Sreedev Kodichath

# Sys
alias ls='eza --color=always'
alias la='eza -a --color=always'
alias ll='eza -l --icons --color=always'
alias lla='eza -la --icons --color=always'
alias tree='eza -aT --color=always --group-directories-first'
alias obliterate='shred -zvu -n 5'
alias xo='xdg-open'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias jctl="journalctl -p 3 -xb"
alias macs="emacsclient -c -a 'emacs'"
alias clock="tty-clock -csSbt -C3"

# Taskwarrior
alias tt="taskwarrior-tui"

# Safe Opts
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -iv"

alias e="$EDITOR"

# Tmuxinator - Tmux Session Manager
alias mux='tmuxinator'
alias t="tmux"
alias ta="tmux a"

# git
alias g='git'

# Docker
alias dc='docker-compose'

# yt-dlp
alias yt-dlp='yt'
