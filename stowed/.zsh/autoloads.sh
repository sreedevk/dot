#!/usr/bin/zsh

# ASDF AUTOLOADS
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . $HOME/.asdf/asdf.sh
  fpath=(${ASDF_DIR}/completions $fpath)
fi

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
  eval "$(zoxide init zsh)"
fi

# LUAROCKS AUTOLOAD
if command -v luarocks &> /dev/null; then
  eval "$(luarocks path --bin)"
fi

# HASKELL AUTOLOADS
if [ -f "$HOME/.ghcup/env" ]; then
   source $HOME/.ghcup/env
fi

# RUST AUTOLOADS
if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

# GOLANG AUTOLOADS
if command -v go &> /dev/null; then
  eval "$(go env)"
fi

# if command -v atuin &> /dev/null; then
#   zvm_after_init_commands+=('eval "$(atuin init zsh --disable-up-arrow)"')
# fi

[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
