{ pkgs, ... }:
pkgs.writeShellScriptBin "bwfzf" ''
  ${pkgs.rbw}/bin/rbw unlock

  item=$(${pkgs.rbw}/bin/rbw list | \
    ${pkgs.gnugrep}/bin/grep -ivE 'nsfw|deleted|archived|deactivated|old' | \
    ${pkgs.fzf}/bin/fzf --tmux) || exit 1

  if [ -n "$item" ]; then
    password=$(${pkgs.rbw}/bin/rbw get "$item")
    printf '%s' "$password" | ${pkgs.wl-clipboard}/bin/wl-copy
    ${pkgs.rbw}/bin/rbw lock
  fi
''
