#!/usr/bin/env zsh

set -e

if [[ -z $1 ]]; then
  echo "no inputs provided"
  return 1
fi

cleanup () {
  echo "[RWC] re-encrypting before exit on error..."
  git crypt lock
}

trap 'cleanup' EXIT
trap 'cleanup' SIGINT

echo "[RWC] running gc & decrypting secrets..."
nix-collect-garbage &>/dev/null
git crypt unlock || true

eval $@

echo "[RWC] encrypting secrets & running gc..."
git crypt lock
nix-collect-garbage &>/dev/null

trap - EXIT
