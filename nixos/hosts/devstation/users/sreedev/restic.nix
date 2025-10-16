{ pkgs
, config
, ...
}:
{

  home.packages = with pkgs; [
    restic
  ];

  services.restic = {
    enable = true;
    backups = {
      "sreedev@devstation" = {
        repository = "sftp:nullptr.sh:/mnt/dpool1/backups/sreedev@devstation";
        passwordFile = config.age.secrets.restic_backup_password.path;
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 6"
          "--keep-yearly 0"
        ];
        paths = builtins.map (v: "${builtins.getEnv "HOME"}/${v}") [
          ".thunderbird"
          "Data/finances"
          "Data/work"
          "Data/resources"
          "Data/notebook"
        ];
        runCheck = true;
        timerConfig = {
          OnCalendar = "00:05";
          Persistent = true;
          RandomizedDelaySec = "5h";
        };
      };
    };
  };
}
