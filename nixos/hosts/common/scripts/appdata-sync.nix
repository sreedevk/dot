{ pkgs, opts, ... }:
let
  appdata-sync =
    pkgs.writeShellScriptBin "backup-appdata" ''
      rsync -aAXv --progress --delete --size-only "${opts.paths.application_data}" "${opts.paths.application_data_archive}"
      rsync -aAXv --progress --delete --size-only "${opts.paths.application_databases}" "${opts.paths.application_databases_archive}"
    '';
in
{
  environment.systemPackages = [ appdata-sync ];
}
