{ pkgs, ... }:
pkgs.writeShellScriptBin "bwfzf" ''
  ${pkgs.rbw}/bin/rbw unlock
  item=$(${pkgs.rbw}/bin/rbw list | \
    ${pkgs.gnugrep}/bin/grep -ivE 'nsfw|deleted|archived|deactivated|old' | \
    ${pkgs.fzf}/bin/fzf) || exit 1

  if [ -n "$item" ]; then
    password=$(${pkgs.rbw}/bin/rbw get "$item")
    printf '%s' "$password" | ${pkgs.wl-clipboard}/bin/wl-copy
    printf '%s' "$password" | tmux load-buffer -
    ${pkgs.systemd}/bin/systemd-run       \
      --user                              \
      --unit="clearclipboard-$(date +%s)" \
      --on-active="30s"                   \
      --description="Clear clipboard"     \
      ${pkgs.wl-clipboard}/bin/wl-copy < /dev/null && ${pkgs.rbw}/bin/rbw lock
  fi
''
