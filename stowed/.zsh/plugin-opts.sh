# VI MODE
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
zvm_after_init_commands+=('[ -f "/usr/share/fzf/key-bindings.zsh" ] && source /usr/share/fzf/key-bindings.zsh')
zvm_after_init_commands+=('[ -f "/usr/share/fzf/completion.zsh"   ] && source /usr/share/fzf/completion.zsh')


# FZF
export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)

zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'bat --color=always ${(Q)realpath} 2> /dev/null'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
