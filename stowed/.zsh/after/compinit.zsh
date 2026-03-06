#!/usr/bin/zsh

# POST COMPINIT AUTOLOADS
if command -v jj &> /dev/null; then
  source <(jj util completion zsh)
fi

# MISE AUTOLOADS
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v opam &> /dev/null; then
  eval $(opam env)
fi

if command -v pueue &> /dev/null; then
  eval "$(pueue completions zsh)"
fi

if command -v just &> /dev/null; then
  eval "$(just --completions zsh)"
fi

if command -v docker &> /dev/null; then
  eval "$(docker completion zsh)"
fi

if command -v jira &> /dev/null; then
  eval "$(jira completion zsh)"
fi

if command -v rbw &> /dev/null; then
  eval "$(rbw gen-completions zsh)"
fi

if command -v rv &> /dev/null; then
  eval "$(rv shell init zsh)"
  eval "$(rv shell completions zsh)"
fi

# ZOXIDE
export _ZO_MAXAGE=500
export _ZO_RESOLVE_SYMLINKS=1

# VI MODE
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

[ -f "/usr/share/fzf/key-bindings.zsh" ] && zvm_after_init_commands+=('source /usr/share/fzf/key-bindings.zsh')
[ -f "/usr/share/fzf/completion.zsh"   ] && zvm_after_init_commands+=('source /usr/share/fzf/completion.zsh')
[ -f "$HOME/.zsh/plugins.zsh" ]          && source "$HOME/.zsh/plugins.zsh"

export FZF_DEFAULT_OPTS="--height 60% \
--info=inline    \
--border sharp   \
--prompt '∷ '    \
--pointer ▶      \
--marker ⇒       \
--select-1       \
--exit-0         \
--min-height=10  \
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
--bind tab:accept"

export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light ajeetdsouza/zoxide
zinit light hlissner/zsh-autopair
zinit light wintermi/zsh-mise
zinit light olets/zsh-abbr

[ -f "$HOME/.zsh/after/zinit.zsh" ] && source "$HOME/.zsh/after/zinit.zsh"
