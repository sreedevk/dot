{ pkgs, ... }:
let
  appdata-sync =
    pkgs.writeShellScriptBin "backup-appdata" ''
      echo "hello world";
    '';
in
{
  environment.systemPackages = [ appdata-sync ];
}
