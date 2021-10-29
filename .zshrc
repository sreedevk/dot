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
DOOM_PATH="$HOME/.doomacs.d/bin/"
CARGO_PATH="$HOME/.cargo/bin"
ASPEN_PATH="$HOME/.aspen/bin"
CUSTOM_SCRIPTS_PATH=$HOME/.scripts
export PATH="$PATH:$YARN_PATH:$CONDA_PATH:$GO_PATH:$DBEAVER_PATH:$KENDRYTE_PATH:$MAIXPY_PATH:$MRUBY_PATH:$DOOM_PATH:$CARGO_PATH:$ASPEN_PATH:$CUSTOM_SCRIPTS_PATH"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export VISUAL="nvim"
export EDITOR=nvim
export TERMINFO=/usr/share/terminfo/
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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
[ -f "$HOME/.zsh/.zsh_aliases" ]   && source "$HOME/.zsh/.zsh_aliases"
[ -f "$HOME/.zsh/.zsh_functions" ] && source "$HOME/.zsh/.zsh_functions"
[ -f "$HOME/.zsh/.zsh_autoloads" ]  && source "$HOME/.zsh/.zsh_autoloads"
[ -f "$HOME/.zsh/.zsh_fzf" ]        && source "$HOME/.zsh/.zsh_fzf"

# ANTIBODY COMPILE ZSH
# antibody bundle < ~/.zsh/.zsh_plugins > ~/.zsh/.zsh_plugins.sh

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/.zsh_plugins.sh" ] && source ~/.zsh/.zsh_plugins.sh

# FIX COLOR SCHEME ISSUES IN SYNTAX HIGHLIGHTING
ZSH_HIGHLIGHT_STYLES[comment]='none'

# START STARSHIP PROMPT
eval "$(starship init zsh)"
