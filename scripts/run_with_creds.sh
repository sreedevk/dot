#!/usr/bin/env zsh

set -xe

if [[ -z $1 ]]; then
  echo "no inputs provided"
  return 1
fi

nix-collect-garbage
git crypt unlock
eval $@
git crypt lock
nix-collect-garbage
