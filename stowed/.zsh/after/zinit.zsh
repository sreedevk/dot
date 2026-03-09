[ -f "$HOME/.zsh/abbr.zsh" ] && source "$HOME/.zsh/abbr.zsh"

! whence -w _aws >/dev/null && [[ $commands[aws_completer] ]] &&
	complete -C $(which aws_completer) aws

! whence -w _gh >/dev/null && [[ $commands[gh] ]] &&
	source <(gh completion -s zsh)

! whence -w _fzf >/dev/null && [[ $commands[fzf] ]] &&
	source <(fzf --zsh)

! whence -w _kubectl >/dev/null && [[ $commands[kubectl] ]] &&
	source <(kubectl completion zsh)

zstyle ':completion:*'                    auto-description 'specify: %d'
zstyle ':completion:*'                    completer _expand _complete _correct _approximate
zstyle ':completion:*'                    format 'Completing %d'
zstyle ':completion:*'                    group-name ''
zstyle ':completion:*'                    menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default'            list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*'                    list-colors ''
zstyle ':completion:*'                    list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*'                    matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*'                    menu select=long
zstyle ':completion:*'                    select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*'                    use-compctl false
zstyle ':completion:*'                    verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*'             command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:systemctl:*'      services  '/etc/systemd/system/*.service' '/usr/lib/systemd/system/*.service' "$HOME/.config/systemd/user/*.service"

zstyle ':fzf-tab:*'                                 group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*'                                 fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*'                                 popup-min-size 50 8
zstyle ':fzf-tab:complete:diff:*'                   popup-min-size 80 12
zstyle ':fzf-tab:*'                                 switch-group '<' '>'
zstyle ':fzf-tab:*'                                 use-fzf-default-opts yes
zstyle ':fzf-tab:*'                                 fzf-min-height 15
zstyle ':fzf-tab:complete:cd:*'                     fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-show:*'               fzf-preview $FZF_GIT_SHOW_PREVIEW
zstyle ':fzf-tab:complete:ls:*'                     fzf-preview '[[ -d ${(Q)realpath} ]] && eza -1 --color=always ${(Q)realpath} || bat --color=always ${(Q)realpath} 2> /dev/null'
zstyle ':fzf-tab:complete:systemctl-*:*'            fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:systemctl-cat:*'          fzf-preview 'SYSTEMD_COLORS=1 systemctl cat -- $word | bat -lini'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest'  fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
