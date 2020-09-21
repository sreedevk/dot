# Title  :  ZSH Config
# Author :  Sreedev Kodichath
# Created:  21/09/2020

export KEYTIMEOUT=1
export EDITOR=nvim
export PATH="$PATH:$HOME/scripts/:$HOME/.yarn/bin:$HOME/anaconda3/bin:$HOME/.rbenv/bin:$HOME/go/bin/"
export TERM=xterm-256color
export SDKMAN_DIR="$HOME/.sdkman"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
#     --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
#     --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
#     --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'
# 
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

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

FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger,$print_query' # For continuous completion and print query
    --color fg:124,bg:233,hl:202,fg+:214,bg+:52,hl+:231
    --color info:52,prompt:196,spinner:208,pointer:196,marker:208
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
    --print-query
)

# static loading (to be run when plugins updated)
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
# Basic auto/tab complete:
autoload -Uz compinit
compinit
source ~/.zsh_plugins.sh

zstyle ':completion:*' menu select
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
# give a preview of directory by exa when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND



# vi mode
bindkey -v

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

echo -ne '\e[2 q'                # Use beam shape cursor on startup.
precmd() { echo -ne '\e[2 q' ;}  # Use beam shape cursor for each new prompt.


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
