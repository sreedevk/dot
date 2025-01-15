#!/usr/bin/zsh

# VI MODE
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
[ -f "/usr/share/fzf/key-bindings.zsh" ] && zvm_after_init_commands+=('source /usr/share/fzf/key-bindings.zsh')
[ -f "/usr/share/fzf/completion.zsh"   ] && zvm_after_init_commands+=('source /usr/share/fzf/completion.zsh')
[ -f "$HOME/.zsh/plugins.zsh" ] && source "$HOME/.zsh/plugins.zsh"


export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)
export FZF_DEFAULT_OPTS="--height 60% \
--info=inline    \
--border sharp   \
--layout reverse \
--prompt '∷ '    \
--pointer ▶      \
--marker ⇒       \
--select-1       \
--exit-0         \
--min-height=10  \
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
--bind tab:accept"

export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS
export FZF_TMUX=1
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

FZF_GIT_SHOW_PREVIEW='case "$group" in
    "commit tag") git show --color=always $word ;;
    *) git show --color=always $word | delta ;;
    esac'

zstyle ':completion:*'                               menu select
zstyle ':completion:*'                               matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*'                               accept-exact '*(N)'
zstyle ':completion:*'                               use-cache on
zstyle ':completion:*'                               cache-path ~/.cache/zsh
zstyle ':completion:*'                               rehash true
zstyle ':completion:*'                               list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions'                  format '[%d]'
zstyle ':completion:*:git-checkout:*'                sort false
zstyle ':completion:*:*:*:*:processes'               command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:systemctl:*'                 command 'systemctl list-units --all --state=running,exited,failed --plain' '--type=service'
zstyle ':completion:*:*:systemctl:*'                 services  '/etc/systemd/system/*.service' '/usr/lib/systemd/system/*.service' "$HOME/.config/systemd/user/*.service"

zstyle ':fzf-tab:*'                                  fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*'                                  group-colors $FZF_TAB_GROUP_COLORS
zstyle ':fzf-tab:*'                                  popup-min-size 50 8
zstyle ':fzf-tab:*'                                  switch-group '<' '>'
zstyle ':fzf-tab:*'                                  use-fzf-default-opts yes
zstyle ':fzf-tab:*'                                  fzf-min-height 15
zstyle ':fzf-tab:complete:cd:*'                      fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:diff:*'                    popup-min-size 80 12
zstyle ':fzf-tab:complete:git-(add|diff|restore):*'  fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-show:*'                fzf-preview $FZF_GIT_SHOW_PREVIEW
zstyle ':fzf-tab:complete:ls:*'                      fzf-preview '[[ -d ${(Q)realpath} ]] && eza -1 --color=always ${(Q)realpath} || bat --color=always ${(Q)realpath} 2> /dev/null'
zstyle ':fzf-tab:complete:systemctl-*:*'             fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:systemctl-cat:*'           fzf-preview 'SYSTEMD_COLORS=false systemctl cat -- $word | bat -lini'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest'   fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light ajeetdsouza/zoxide
zinit light hlissner/zsh-autopair
