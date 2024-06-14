{ configs, pkgs, secrets, username, ... }: {
  systemd.user = {
    enable = true;
    services = {
      taskwarrior-sync = {
        Unit = {
          Description = "Taskwarrior3 Taskchampion Sync Job";
          Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
          Restart = "always";
        };
      };
    };

    timers = {
      taskwarrior-sync-timers = {
        Unit = {
          Description = "Timer for Taskwarrior3 (TaskChampion) Sync Service";
        };
        Timer = {
          OnBootSec = "5min";
          OnUnitActiveSec = "30min";
        };
      };
    };
  };
}
