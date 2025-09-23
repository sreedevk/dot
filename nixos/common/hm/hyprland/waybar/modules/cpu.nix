{ pkgs, ... }:
pkgs.writeShellScriptBin "cpu-temp" ''
  echo "$(sensors | grep "Package" | awk '{print $4}')"
''
