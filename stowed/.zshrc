# TITLE: Zsh (Z Shell) Configuration
# AUTHOR: Sreedev Kodichath

# LOADS ZSH PROFILER
## zmodload zsh/zprof

# PATHS
YARN_PATH="$HOME/.yarn/bin"
CONDA_PATH="/opt/anaconda/bin"
GO_PATH="$HOME/go/bin/"
DBEAVER_PATH="/opt/dbeaver/"
KENDRYTE_PATH="/opt/kendryte-toolchain/bin"
MAIXPY_PATH="/opt/maixpy-ide/bin/"
MRUBY_PATH="/opt/mruby/bin"
DOOM_PATH="$HOME/.emacs-distros/doom-emacs/bin" 
CARGO_PATH="$HOME/.cargo/bin"
LOCAL_BIN_PATH="$HOME/.local/bin"
CUSTOM_SCRIPTS_PATH=$HOME/.scripts
SNAP_PATH=/snap/bin
RPI0W_TOOLCHAIN_PATH=/opt/rpi0w-toolchain/bin
SURREAL_DB_PATH="$HOME/.surrealdb"
export PATH="$PATH:$YARN_PATH:$CONDA_PATH:$GO_PATH:$DBEAVER_PATH:$KENDRYTE_PATH:$MAIXPY_PATH:$MRUBY_PATH:$DOOM_PATH:$CARGO_PATH:$CUSTOM_SCRIPTS_PATH:$SNAP_PATH:$LOCAL_BIN_PATH:$RPI0W_TOOLCHAIN_PATH:$SURREAL_DB_PATH"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export VISUAL="nvim"
export EDITOR=nvim
export TERM=xterm-256color
export TERMINFO=/usr/share/terminfo/
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8

# HISTORYFILE
HISTSIZE=100
SAVEHIST=100

# NON INTERACTIVE MODE EARLY RETURN
[[ $- != *i* ]] && return

# KEY BINDINGS
bindkey -s '^o' 'lfcd\n'
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line

# ASDF AUTOCOMPLETE
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# AUTOLOAD MODULES
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line; zle -N edit-command-line

# ZSH OPTS
setopt PROMPT_SUBST
setopt interactivecomments

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh/aliases" ]   && source "$HOME/.zsh/aliases"
[ -f "$HOME/.zsh/functions" ] && source "$HOME/.zsh/functions"
[ -f "$HOME/.zsh/autoloads" ] && source "$HOME/.zsh/autoloads"
[ -f "$HOME/.zsh/fzf" ]       && source "$HOME/.zsh/fzf"
[[ ! -r /home/sreedev/.opam/opam-init/init.zsh ]] || source /home/sreedev/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# ANTIBODY COMPILE ZSH
# antibody bundle < ~/.zsh/.zsh_plugins > ~/.zsh/.zsh_plugins.sh

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/plugins.sh" ] && source ~/.zsh/plugins.sh

# FIX COLOR SCHEME ISSUES IN SYNTAX HIGHLIGHTING
ZSH_HIGHLIGHT_STYLES[comment]='none'

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0403c58
  \e]P1ea6f91
  \e]P29bced7
  \e]P3f1ca93
  \e]P434738e
  \e]P5c3a5e6
  \e]P6eabbb9
  \e]P7faebd7
  \e]P86f6e85
  \e]P9ea6f91
  \e]PA9bced7
  \e]PBf1ca93
  \e]PC34738e
  \e]PDc3a5e6
  \e]PEeabbb9
  \e]PFffffff
  "
  # get rid of artifacts
  clear
fi
