{ pkgs, ... }:
pkgs.writeShellScriptBin "tmux-desessionizer" ''
  set -euo pipefail

  csession=$(tmux display-message -p "#S")
  cwd=$(tmux display-message -p "#{pane_current_path}")
  bsn=$(basename "$cwd")
  norm_name=$(echo "$bsn" | tr "[:upper:] " "[:lower:]_" | tr -cd "[:alnum:]_")

  root_conf="$cwd/.tmuxinator.conf"
  user_conf="$HOME/.config/tmuxinator/$norm_name.yml"

  (tmux has-session -t system 2>/dev/null || tmux new-session -d -s system) && \
    tmux switch-client -t system

  if [[ -f "$root_conf" ]]; then
    tmux send-keys -t target_session_name "${pkgs.tmuxinator}/bin/tmuxinator stop" C-m
  elif [[ -f "$user_conf" ]]; then
    tmux neww "${pkgs.tmuxinator}/bin/tmuxinator stop $norm_name"
  else
    tmux kill-session -t $csession
  fi
''
