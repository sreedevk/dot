{ pkgs, ... }:
pkgs.writeShellScriptBin "memory" ''
  echo "$(free --giga --human | awk 'NR==2 {printf "%.2f/%.2f G", $3, $2}')"
''
