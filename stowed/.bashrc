# TITLE: Bash (Bourne-Again Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
LOCAL_BIN_PATH="$HOME/.local/bin"
LOCAL_BIN_SUB_PATH="$HOME/.local/bin/**/*"

export GOPATH="$HOME/go"
export PATH="$PATH:$LOCAL_BIN_PATH:$LOCAL_BIN_SUB_PATH:$GOPATH"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export VISUAL=neovide
export EDITOR=nvim
export TERMINFO=/usr/share/terminfo/
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTCONTROL=erasedups:ignoredups:ignorespace

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# VIM BINDINGS
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-insert 'Control-a: beginning-of-line'
bind -m vi-insert 'Control-e: end-of-line'
bind -m vi-insert 'Control-k: previous-history'
bind -m vi-insert 'Control-j: next-history'

# AUTOLOAD ASDF VM
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# AUTOLOADS 
if [ -f "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi

if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init bash)"
fi

if [ -f "$(command -v luarocks)" ]; then
  eval "$(luarocks path --bin)"
fi

if [ -f "$(command -v atuin)" ]; then
  eval "$(atuin init bash --disable-up-arrow)"
fi

if [ -f "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

# SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# ALIASES
alias ls='exa --color=always'
alias la='exa -a --color=always'
alias ll='exa -l --color=always'
alias lla='exa -la --color=always'
alias lt='exa -aT --color=always --group-directories-first'
alias obliterate='shred -zvu -n 5'
alias xo='xdg-open'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias jctl="journalctl -p 3 -xb"
alias macs="emacsclient -c -a 'emacs'"
alias nvide="WINIT_X11_SCALE_FACTOR=1.2 neovide --multigrid"
alias lg="lazygit"
alias t="tmux"
alias ta="tmux a"
alias clock="tty-clock -csSb -C3"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -iv"
alias mkdir="mkdir -p"
alias tree='eza -aT --color=always --group-directories-first'

# FZF CONFIG
export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)
export FZF_DEFAULT_OPTS="
 --multi --no-height --extended
 --color=fg:#e0def4,hl:#6e6a86
 --color=fg+:#908caa,hl+:#908caa
 --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
 --color=marker:#ebbcba,spinner:#eb6f92,header:#ebbcba"

eval "$(command -v fastfetch)"
