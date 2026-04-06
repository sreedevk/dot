{ pkgs, ... }:
pkgs.writeShellScriptBin "ssh-fzf" ''
  server=$(grep -E '^Host ' ~/.ssh/config | awk '{print $2}' | fzf --tmux)
  if [[ -n $server ]] then
    ssh $server
  fi
''
