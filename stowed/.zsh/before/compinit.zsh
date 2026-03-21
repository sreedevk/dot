#!/usr/bin/zsh

# DIRENV LOAD
if command -v direnv-instant &> /dev/null; then
  eval "$(direnv-instant hook zsh)"
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

export FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[38;5;27m' $'\033[36m' \
    $'\033[38;5;100m' $'\033[38;5;98m' $'\033[91m' $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)

export FZF_GIT_SHOW_PREVIEW='case "$group" in
    "commit tag") git show --color=always $word ;;
    *) git show --color=always $word | delta ;;
    esac'
