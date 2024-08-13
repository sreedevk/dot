{ pkgs, opts, username, ... }:
let
  sync-backups-archives =
    pkgs.writeShellScriptBin "sync-backups-archives" ''
      ${pkgs.rsync}/bin/rsync -aAXv --progress --delete --size-only /opt/backups nullptr.sh:/mnt/dpool0/backups/devstation/
    '';

  create-backup-archives =
    pkgs.writeShellScriptBin "create-backup-archives" ''
      ${pkgs.p7zip}/bin/7z a -t7z -mx=9 /opt/backups/data-tunecore-archive-$(date -I).7z /home/${username}/Data/tunecore
      ${pkgs.p7zip}/bin/7z a -t7z -mx=9 /opt/backups/data-notebook-archive-$(date -I).7z /home/${username}/Data/notebook
    '';
in
{
  home.packages = [ create-backup-archives sync-backups-archives ];

  systemd.user = {
    services = {
      create-backup-archives = {
        Unit = { Description = "create backup archives"; };
        Service = {
          Type = "simple";
          ExecStart = "${create-backup-archives}/bin/create-backup-archives";
        };
      };

      sync-backups-archives = {
        Unit = { Description = "sync backup archives"; };
        Service = {
          Type = "simple";
          ExecStart = "${sync-backups-archives}/bin/sync-backups-archives";
        };
      };

    };

    timers = {
      sync-backups-archives-timers = {
        Unit = {
          Description = "Timer for syncing backup archives";
        };
        Timer = {
          OnBootSec = "4h";
          OnUnitActiveSec = "1w";
          Unit = "sync-backups-archives.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };

      create-backup-archives-timers = {
        Unit = {
          Description = "Timer for creating backup archives";
        };
        Timer = {
          OnBootSec = "4h";
          OnUnitActiveSec = "1d";
          Unit = "create-backup-archives.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
