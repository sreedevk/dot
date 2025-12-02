{ pkgs
, config
, opts
, username
, ...
}:
{

  home.packages = with pkgs; [
    restic
  ];

  systemd.user.sessionVariables = {
    RESTIC_PASSWORD_FILE = "${config.age.secrets.restic_backup_password.path}";
    RESTIC_REPOSITORY = "sftp:apollo:/mnt/dpool1/backups/${username}@${opts.hostname}";
  };

  home.sessionVariables = {
    RESTIC_PASSWORD_FILE = "${config.age.secrets.restic_backup_password.path}";
    RESTIC_REPOSITORY = "sftp:apollo:/mnt/dpool1/backups/${username}@${opts.hostname}";
  };

  systemd.user = {
    services = {
      restic-backup = {
        Unit = {
          Description = "Restic Backup Process to Apollo Server";
          Documentation = "info:restic man:restic backup(1)";
          After = [
            "network-online.target"
          ];
          Wants = [
            "network-online.target"
          ];
        };
        Service = {
          Type = "oneshot";
          Environment = [
            "RESTIC_PASSWORD_FILE=${config.age.secrets.restic_backup_password.path}"
            "RESTIC_REPOSITORY=sftp:nullptr.sh:/mnt/dpool1/backups/${username}@${opts.hostname}"
          ];

          ExecStart =
            let
              homedir = dirs: (builtins.map (v: "${builtins.getEnv "HOME"}/${v}") dirs);
              backupdirs = builtins.concatStringsSep " " (homedir [
                ".thunderbird"
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
              "${pkgs.restic}/bin/restic forget --prune --keep-daily 7 --keep-weekly 5 --keep-monthly 6 --keep-yearly 0"
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
          OnCalendar = "daily";
          RandomizedDelaySec = "5h";
          Persistent = true;
          Unit = "restic-backup.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
