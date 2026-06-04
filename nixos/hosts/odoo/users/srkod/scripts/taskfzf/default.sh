#!/usr/bin/env bash
set -euo pipefail

if [[ -f "$PWD/Rakefile" ]]; then
  task=$(rake -AT | awk '{ print $1 " " $2 }' | fzf --tmux)
fi
