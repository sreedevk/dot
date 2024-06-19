#!/usr/bin/env zsh

set -xe

if [[ -z $1 ]]; then
  echo "no inputs provided"
  return 1
fi

echo "running gc & decrypting secrets..."
nix-collect-garbage &>/dev/null
git crypt unlock

eval $@

echo "encrypting secrets & running gc..."
git crypt lock
nix-collect-garbage &>/dev/null
