#!/usr/bin/zsh

# POST COMPINIT AUTOLOADS
if command -v jj &> /dev/null; then
  source <(jj util completion zsh)
fi
