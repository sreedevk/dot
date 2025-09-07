{ pkgs, ... }:
pkgs.writeShellScriptBin "bwfzf" ''
  bw_exec=${pkgs.bitwarden-cli}/bin/bw
  item=$("$bw_exec" list items 2>/dev/null | \
    ${pkgs.jq}/bin/jq -r '.[].name' | \
    ${pkgs.gnugrep}/bin/grep -ivE 'nsfw|deleted|archived|deactivated|old' | \
    ${pkgs.fzf}/bin/fzf) || exit 1

  if [ -n "$item" ]; then
    password=$("$bw_exec" get password "$item" 2>/dev/null)
    printf '%s' "$password" | ${pkgs.wl-clipboard}/bin/wl-copy
    printf '%s' "$password" | tmux load-buffer -

    ${pkgs.systemd}/bin/systemd-run \
      --user \
      --unit="clearclipboard-$(date +%s)" \
      --on-active="30s" \
      --description="Clear clipboard" \
      ${pkgs.wl-clipboard}/bin/wl-copy < /dev/null
  fi
''
