# LOADS ZSH PROFILER
# zmodload zsh/zprof

# PATHS
YARN_PATH="$HOME/.yarn/bin"
CONDA_PATH="/opt/anaconda/bin"
GO_PATH="$HOME/go/bin/"
DBEAVER_PATH="/opt/dbeaver/"
KENDRYTE_PATH="/opt/kendryte-toolchain/bin"
MAIXPY_PATH="/opt/maixpy-ide/bin/"
MRUBY_PATH="/opt/mruby/bin"
DOOM_PATH="$HOME/.doomemacs.d/bin/"
export PATH="$PATH:$YARN_PATH:$CONDA_PATH:$GO_PATH:$DBEAVER_PATH:$KENDRYTE_PATH:$MAIXPY_PATH:$MRUBY_PATH:$DOOM_PATH"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
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
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# ASDF AUTOCOMPLETE
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
# antibody bundle < ~/.zsh/.zsh_plugins.txt > ~/.zsh/.zsh_plugins.sh

# LOAD COMPILED PLUGINS
[ -f "$HOME/.zsh/.zsh_plugins.sh" ] && source ~/.zsh_plugins.sh

# START STARSHIP PROMPT
eval "$(starship init zsh)"
