#!/usr/bin/env zsh

set -e

if [[ -z $1 ]]; then
  return 1
fi

  echo "no inputs provided"
git_lock_secret() {
  encstat="$(git crypt status nixos/secrets | awk '{print $1}' | grep -o -E '^\s+(encrypted|not encrypted)')"
  if [[ "$encstat" == *'not encrypted'* ]]; then
    git crypt lock
  fi
}

git_unlock_secret() {
  encstat="$(git crypt status nixos/secrets | awk '{print $1}')"
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
