#!/usr/bin/env zsh

set -e

if [[ -z $1 ]]; then
  echo "no inputs provided"
  return 1
fi

git_lock_secret() {
  encstat="$(git crypt status nixos/secrets)"
  if [[ "$encstat" == *'not encrypted'* ]]; then
    git crypt lock
  fi
}

git_unlock_secret() {
  encstat="$(git crypt status nixos/secrets)"
  if [[ "$encstat" != *'not encrypted'* ]]; then
    git crypt unlock
  fi
}

cleanup() {
  echo "[RWC] re-encrypting before exit on error..."
  git_lock_secret
}

trap 'cleanup' EXIT

echo "[RWC] running gc & decrypting secrets..."
nix-collect-garbage &>/dev/null
git_unlock_secret

eval $@

echo "[RWC] encrypting secrets & running gc..."
git_lock_secret
nix-collect-garbage &>/dev/null
