{ pkgs, opts, ... }:
let
  appdata-sync =
    pkgs.writeShellScriptBin "appdata-sync" ''
      rsync -aAXv --progress --delete --size-only "${opts.paths.application_data}/" "${opts.paths.application_data_archive}/"
      rsync -aAXv --progress --delete --size-only "${opts.paths.application_databases}/" "${opts.paths.application_databases_archive}/"
    '';
in
{
  environment.systemPackages = [ appdata-sync ];

  # systemd.services.appdata-sync = {
  #   description = "appdata sync";
  #   enable = true;
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     ExecStart = ''
  #       ${pkgs.taskchampion-sync-server}/bin/taskchampion-sync-server --port ${opts.ports.taskchampion} --data-dir ${opts.paths.application_data}/TaskChampion
  #     '';
  #     Restart = "always";
  #   };
  # };

}
