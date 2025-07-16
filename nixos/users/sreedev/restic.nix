{ config, ... }:
{
  services.restic = {
    enable = true;
    backups = {
      remote-backup-nullptrderef1 = {
        repository = "sftp:nullptrderef1:/mnt/dpool0/backups/devstation/restic-repository";
        passwordFile = config.age.secrets.restic_backup_password.path;
        initialize = false;
        paths = [
          "${builtins.getEnv "HOME"}/Data/work"
          "${builtins.getEnv "HOME"}/Data/finances"
          "${builtins.getEnv "HOME"}/Data/notebook"
          "${builtins.getEnv "HOME"}/Data/resources"
        ];
        pruneOpts = [ "--keep-daily 7" ];
        timerConfig = {
          OnCalendar = "00:05";
          RandomizedDelaySec = "5h";
        };
      };
    };
  };
}
