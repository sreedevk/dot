{ pkgs, ... }:
pkgs.writeShellScriptBin "dnd" ''
  [[ "$(${pkgs.dunst}/bin/dunstctl is-paused)" == "true" ]] && echo " " || echo " "
''
