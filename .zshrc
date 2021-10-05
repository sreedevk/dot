# zmodload zsh/zprof

export PATH="$PATH:$HOME/.yarn/bin:/opt/anaconda/bin:$HOME/go/bin/:/opt/dbeaver/:/opt/infrastructure/clojure/bin:/opt/kendryte-toolchain/bin:/opt/maixpy-ide/bin/:/opt/mruby/bin:/home/sreedev/.asdf/installs/rust/1.54.0/bin"

# ENV VARIABLES
export KEYTIMEOUT=1
export GPG_TTY=$(tty)
export EDITOR=nvim
export TERMINFO=/usr/share/terminfo/
export TERM="xterm-256color"
export HISTFILE=~/.cache/zsh/history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NVM_DIR="$HOME/.nvm"

# HISTORYFILE
HISTSIZE=100
SAVEHIST=100

# ASDF AUTOCOMPLETE
fpath=(${ASDF_DIR}/completions $fpath)


# Autoload Modules
autoload -U colors && colors
autoload -U compinit && compinit
autoload edit-command-line; zle -N edit-command-line

# set options
setopt PROMPT_SUBST
setopt interactivecomments

# static loading (to be run when plugins updated)
# antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# LOAD ALIASES & FUNCTIONS
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"
[ -f "$HOME/.zsh_funcs" ]   && source "$HOME/.zsh_funcs"
# [ -f "/usr/share/zsh/manjaro-zsh-prompt" ] && source /usr/share/zsh/manjaro-zsh-prompt
# [ -f "/usr/share/zsh/manjaro-zsh-config" ] && source /usr/share/zsh/manjaro-zsh-config

# LOAD PLUGINS
source ~/.zsh_plugins.sh

export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)


# group colors
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
# fzf completions
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# key bindings
bindkey -s '^o' 'lfcd\n'
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^x' edit-command-line
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(direnv hook zsh)"

# source /etc/bash_completion.d/climate_completion
. $HOME/.asdf/asdf.sh

# source /etc/bash_completion.d/climate_completion
eval "$(starship init zsh)"
