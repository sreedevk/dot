{ pkgs, config, ... }:
{
  systemd.user = {
    services = {
      restic-backup = {
        Unit = {
          Description = "Restic Backup Process to nullptrderef1 Server";
          Documentation = "info:restic man:restic backup(1)";
          After = [
            "network-online.target"
            "agenix.service"
          ];
          Wants = [
            "network-online.target"
            "agenix.service"
          ];
        };
        Service = {
          Type = "oneshot";
          Environment = [
            "RESTIC_PASSWORD_FILE=${config.age.secrets.restic_backup_password.path}"
            "RESTIC_REPOSITORY=sftp:nullptrderef1:/mnt/dpool0/backups/devstation/restic-repository"
          ];

          ExecStart =
            let
              homedir = dirs: (builtins.map (v: "${builtins.getEnv "HOME"}/${v}") dirs);
              backupdirs =
                builtins.concatStringsSep " "
                  (homedir [
                    "Data/finances"
                    "Data/work"
                    "Data/resources"
                    "Data/notebook"
                  ]);
            in
            [
              # backup
              "${pkgs.restic}/bin/restic backup --skip-if-unchanged ${backupdirs}"

              # prune and check
              "${pkgs.restic}/bin/restic unlock"
              "${pkgs.restic}/bin/restic forget --prune --keep-daily 7"
              "${pkgs.restic}/bin/restic check"
            ];
        };
      };
    };

    timers = {
      restic-backup-timers = {
        Unit = {
          Description = "Timer for Restic Backup Process";
        };
        Timer = {
          OnBootSec = "5min";
          OnCalendar = "00:05";
          RandomizedDelaySec = "5h";
          Unit = "restic-backup.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
