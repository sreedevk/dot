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
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias wget="noglob wget"
alias curl="noglob curl"
alias z='__zoxide_z'
alias zz='__zoxide_zi'

# termbin
alias tb="nc termbin.com 9999"

# Safe Opts
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -iv"

alias e="$EDITOR"
alias n="nvim"
