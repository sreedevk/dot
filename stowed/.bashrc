# TITLE: Bash (Bourne-Again Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
export PATH="$PATH:$HOME/.local/bin:/opt/bin"

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

if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

# ALIASES
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
alias clock="tty-clock -csSbt -C3"
alias wget="noglob wget"
alias curl="noglob curl"
alias tt="taskwarrior-tui"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -iv"
alias e="$EDITOR"
alias mux='tmuxinator'
alias t="tmux"
alias ta="tmux a"
alias ts="tmux-sessionizer"
alias g='git'
alias dc='docker-compose'
alias yt='yt-dlp'

# FASTFETCH @ SHELL INIT
if [ -f "$(command -v fastfetch)" ]; then
  (echo -e "\n"; eval "$(command -v fastfetch)"; echo -e "\n")
fi
