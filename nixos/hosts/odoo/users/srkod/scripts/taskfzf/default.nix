{ pkgs, ... }: pkgs.writeShellScriptBin "taskfzf" (builtins.readFile ./default.sh)
