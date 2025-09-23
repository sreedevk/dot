{ pkgs, opts, ... }:
pkgs.writeShellScriptBin "ttd" ''
  TZ=${opts.timeZone} date "+%a %B %d %l:%M:%S %p"
''
