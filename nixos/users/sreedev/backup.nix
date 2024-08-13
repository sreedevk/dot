{ pkgs, opts, username, ... }:
let
  sync-backups-archives =
    pkgs.writeShellScriptBin "sync-backups-archives" ''
      ${pkgs.rsync}/bin/rsync -aAXv --progress --delete --size-only /opt/backups nullptr.sh:/mnt/dpool0/backups/devstation/
    '';

  create-backup-archives =
    pkgs.writeShellScriptBin "create-backup-archives" ''
      ${pkgs.p7zip}/bin/7z a -t7z -mx=9 /opt/backups/$(hostname)-$(date -I)-tunecore-archive.7z /home/${username}/Data/tunecore
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
    };

    timers = {
      create-backup-archives-timers = {
        Unit = {
          Description = "Timer for creating backup archives";
        };
        Timer = {
          OnBootSec = "60min";
          OnUnitActiveSec = "daily";
          Unit = "create-backup-archives.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
