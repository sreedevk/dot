# Title  :  ZSH Config
# Author :  Sreedev Kodichath
# Created:  21/09/2020

export KEYTIMEOUT=1
export EDITOR=nvim
export PATH="$PATH:$HOME/scripts/:$HOME/.yarn/bin:$HOME/anaconda3/bin:$HOME/.rbenv/bin:$HOME/go/bin/"
export TERM=xterm-256color
export SDKMAN_DIR="$HOME/.sdkman"

# Enable colors and change prompt:
autoload -U colors && colors
setopt PROMPT_SUBST
setopt interactivecomments

eval `ssh-agent -s` > /dev/null 2>&1
ssh-add > /dev/null 2>&1

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# static loading (to be run when plugins updated)
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# give a preview of directory by exa when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' continuous-trigger '/'
compinit

source ~/.zsh_plugins.sh

# vi mode
bindkey -v

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'
bindkey '^R' history-incremental-search-backward

# Edit line in vim with ctrl-x:
autoload edit-command-line; zle -N edit-command-line
bindkey '^x' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"
[ -f "$HOME/.zsh_env" ]     && source "$HOME/.zsh_env"
[ -f "$HOME/.zsh_funcs" ]   && source "$HOME/.zsh_funcs"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(direnv hook zsh)"
