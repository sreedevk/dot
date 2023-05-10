#!/usr/bin/zsh

# ASDF AUTOLOADS
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  # ASDF INITIALIZATION
  . $HOME/.asdf/asdf.sh

  # ASDF AUTOCOMPLETIONS
  fpath=(${ASDF_DIR}/completions $fpath)

  # ASDF JAVA INITIALIZATIONS
  [ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ] && . ~/.asdf/plugins/java/set-java-home.zsh
fi

# DIRENV LOAD
if command -v direnv &> /dev/null
then
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
   . $HOME/.ghcup/env
fi

if [ -f "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

if command -v go &> /dev/null; then
  eval "$(go env)"
fi
