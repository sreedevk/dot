# TITLE: ZSH (Z Shell) Aliases
# AUTHOR: Sreedev Kodichath

# Sys
alias ls='eza --color=always'
alias la='eza -a --color=always'
alias ll='eza -l --icons --color=always'
alias lla='eza -la --icons --color=always'
alias lt='eza -aT --color=always --group-directories-first'
alias obliterate='shred -zvu -n 5'
alias xo='xdg-open'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias jctl="journalctl -p 3 -xb"
alias macs="emacsclient -c -a 'emacs'"
alias lg="lazygit"
alias clock="tty-clock -csSb -C3"
alias xcd='cd "$(xplr --print-pwd-as-result)"'
alias bd='cd ..'

alias e="$EDITOR"

# Tmuxinator - Tmux Session Manager
alias mux='tmuxinator'
alias tmux='TERM=screen-256color-bce tmux'
alias t="tmux"
alias ta="tmux a"

# zellij
alias zl='zellij'

# git
alias g='git'

# VirtualBox
alias vboxman='VBoxManage'
alias vboxhl='VBoxHeadless'

# Docker
alias dc='docker-compose'

# Term Bin
alias tb="nc termbin.com 9999"

# YouTube Downloader
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# Keyboard Layout
alias kbl="setxkbmap -layout us,apl -variant ,dyalog -option grp:switch -option caps:ctrl_modifier"
