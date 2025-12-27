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
