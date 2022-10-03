# TITLE: Bash (Bourne-Again Shell) Configuration
# AUTHOR: Sreedev Kodichath

# PATHS
YARN_PATH="$HOME/.yarn/bin"
CONDA_PATH="/opt/anaconda/bin"
GO_PATH="$HOME/go/bin/"
DBEAVER_PATH="/opt/dbeaver/"
KENDRYTE_PATH="/opt/kendryte-toolchain/bin"
MAIXPY_PATH="/opt/maixpy-ide/bin/"
MRUBY_PATH="/opt/mruby/bin"
DOOM_PATH="$HOME/.doomacs.d/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"
export PATH="$PATH:$YARN_PATH:$CONDA_PATH:$GO_PATH:$DBEAVER_PATH:$KENDRYTE_PATH:$MAIXPY_PATH:$MRUBY_PATH:$DOOM_PATH:$LOCAL_BIN_PATH"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export VISUAL="emacsclient -c -a emacs"
export EDITOR=nvim
export TERMINFO=/usr/share/terminfo/
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Vim Bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

eval "$(starship init bash)"

# Shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.3.0/gems/vagrant-2.3.0/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
