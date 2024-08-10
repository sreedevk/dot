{ pkgs, ... }:
let
  backup-appdata =
    pkgs.writeShellScriptBin "backup-appdata" ''
      echo "hello world";
    '';
in
{
  environment.systemPackages = [ backup-appdata ];
}
