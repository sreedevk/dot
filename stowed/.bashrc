# TITLE: Bash (Bourne-Again Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export PATH="$PATH:$HOME/.local/bin:/opt/bin"

# ENV VARIABLES
export VISUAL="neovide"
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
export TZ="America/New_York"

if [ -z "$TMUX" ]; then
  export TERM="xterm-256color"
fi

# HISTORYFILE
export HISTORY_IGNORE="(ls|cd|pwd|exit|history)"
export HISTFILE=$HOME/.cache/bash/history
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

# AUTOLOADS 

# ASDF AUTOLOADS
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
  . "$HOME/.asdf/completions/asdf.bash"
fi

if [ -f "$(command -v direnv)" ]; then
  eval "$(direnv hook bash)"
fi

if [ -f "$(command -v starship)" ]; then
  eval "$(starship init bash)"
fi

if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init bash)"
fi

if [ -f "$(command -v luarocks)" ]; then
  eval "$(luarocks path --bin)"
fi

if [ -f "$HOME/.ghcup/env" ]; then
   source $HOME/.ghcup/env
fi

if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

if command -v go &> /dev/null; then
  eval "$(go env)"
fi

if command -v glow &> /dev/null; then
  eval "$(glow completion bash)"
fi

[[ ! -r $HOME/.opam/opam-init/init.sh ]] || source $HOME/.opam/opam-init/init.sh  > /dev/null 2> /dev/null


# ALIASES
alias ls='eza --color=always'
alias la='eza -a --color=always'
alias ll='eza -l --color=always'
alias lla='eza -la --color=always'
alias lt='eza -aT --color=always --group-directories-first'
alias obliterate='shred -zvu -n 5'
alias xo='xdg-open'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias jctl="journalctl -p 3 -xb"
alias macs="emacsclient -c -a 'emacs'"
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

[ -f "/usr/share/fzf/key-bindings.bash"  ] && source "/usr/share/fzf/key-bindings.bash"
[ -f "/usr/share/fzf/completion.bash"    ] && source "/usr/share/fzf/completion.bash"

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  (echo -e "\n"; eval "$(command -v fastfetch)"; echo -e "\n")
fi
