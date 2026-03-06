#!/usr/bin/zsh

# DIRENV LOAD
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# START STARSHIP PROMPT
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# ZOXIDE - MODERN CD
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh --no-aliases)"
fi

# RUST AUTOLOADS
if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

# FZF AUTOLOAD
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
fi


export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)

export FZF_GIT_SHOW_PREVIEW='case "$group" in
    "commit tag") git show --color=always $word ;;
    *) git show --color=always $word | delta ;;
    esac'


zstyle ':completion:'                                menu select 
zstyle ':completion:'                                matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' 
zstyle ':completion:*'                               accept-exact '*(N)'
zstyle ':completion:*'                               rehash true
zstyle ':completion:*'                               list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions'                  format '[%d]'
zstyle ':completion:*:git-checkout:*'                sort false
zstyle ':completion:*:*:*:*:processes'               command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':fzf-tab:*'                                  group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*'                                  popup-min-size 50 8
zstyle ':fzf-tab:complete:diff:*'                    popup-min-size 80 12
zstyle ':fzf-tab:*'                                  switch-group '<' '>'
zstyle ':fzf-tab:*'                                  use-fzf-default-opts yes
zstyle ':fzf-tab:*'                                  fzf-min-height 15
zstyle ':fzf-tab:complete:cd:*'                      fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*'  fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-show:*'                fzf-preview $FZF_GIT_SHOW_PREVIEW
zstyle ':fzf-tab:complete:ls:*'                      fzf-preview '[[ -d ${(Q)realpath} ]] && eza -1 --color=always ${(Q)realpath} || bat --color=always ${(Q)realpath} 2> /dev/null'
zstyle ':completion:*:*:systemctl:*'                 services  '/etc/systemd/system/*.service' '/usr/lib/systemd/system/*.service' "$HOME/.config/systemd/user/*.service"
zstyle ':fzf-tab:complete:systemctl-*:*'             fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:systemctl-cat:*'           fzf-preview 'SYSTEMD_COLORS=1 systemctl cat -- $word | bat -lini'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest'   fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
