#!/usr/bin/zsh

# POST COMPINIT AUTOLOADS
if command -v jj &> /dev/null; then
  source <(jj util completion zsh)
fi

# ASDF AUTOLOADS
if [ -f "$HOME/.nix-profile/share/asdf-vm/asdf.sh" ]; then
  . "$HOME/.nix-profile/share/asdf-vm/asdf.sh"
  autoload -Uz bashcompinit && bashcompinit
  . "$HOME/.nix-profile/share/asdf-vm/completions/asdf.bash"
fi

if command -v opam &> /dev/null; then
  eval $(opam env)
fi

if command -v pueue &> /dev/null; then
  eval "$(pueue completions zsh)"
fi
