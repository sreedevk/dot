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
  eval "$(zoxide init zsh --no-aliases)"
fi

# RUST AUTOLOADS
if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi
