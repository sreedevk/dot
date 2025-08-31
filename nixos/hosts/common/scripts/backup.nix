{ pkgs, opts, ... }:
let
  appdata-sync = pkgs.writeShellScriptBin "appdata-sync" ''
    ${pkgs.rsync}/bin/rsync -aAXv --progress --delete --size-only "${opts.paths.app_datafiles}/" "${opts.paths.backups}/${opts.hostname}/appdata"
  '';
in
{
  environment.systemPackages = [ appdata-sync ];

  systemd.services.appdata-sync = {
    description = "appdata sync";
    enable = true;
    script = ''
      set -eu
      ${appdata-sync}/bin/appdata-sync
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

  };

  systemd.timers.appdata-sync-trigger = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "10m";
      Unit = "appdata-sync.service";
    };
  };
}
