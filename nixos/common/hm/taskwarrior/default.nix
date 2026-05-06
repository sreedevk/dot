{
  pkgs,
  config,
  opts,
  ...
}:
let
  themes               = import ./theme.nix;
  theme                = "${themes.solarized-dark}.theme";
  taskwarrior-notifier = import ../scripts/taskwarrior-notify.nix { inherit pkgs; };
  utils                = import ./utils.nix;
  coefficients         = import ./coefficients;
  taskConfig           = utils.mkConfig theme opts coefficients;
in
{

  home = {
    packages = with pkgs; [
      taskwarrior3
      taskwarrior-tui
    ];

    sessionVariables =
      if opts.taskwarrior.sync == null then
        { }
      else
        {
          TASKWARRIOR_CLIENT_ID = "$(cat ${config.age.secrets.taskwarrior_client_id.path})";
          TASKWARRIOR_ENCRYPTION_SECRET = "$(cat ${config.age.secrets.taskwarrior_encryption_secret.path})";
        };

    file = {
      ".taskrc" = {
        enable = true;
        text = taskConfig;
        recursive = false;
      };
    };
  };

  systemd.user.sessionVariables = {
    TASKWARRIOR_CLIENT_ID = "$(cat ${config.age.secrets.taskwarrior_client_id.path})";
    TASKWARRIOR_ENCRYPTION_SECRET = "$(cat ${config.age.secrets.taskwarrior_encryption_secret.path})";
  };

  systemd.user = {
    services =
      (
        if opts.taskwarrior.sync == null then
          { }
        else
          {
            taskwarrior-sync = {
              Unit = {
                Description = "Taskwarrior3 Taskchampion Sync Job";
                Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
              };
              Service = {
                Type = "oneshot";
                EnvironmentFile = config.age.secrets.taskwarrior_env.path;
                ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
                RemainAfterExit = true;
              };
            };
          }
      )
      // {
        taskwarrior-notify = {
          Unit = {
            Description = "Taskwarrior3 Notification Job";
            Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
          };
          Service = {
            Type = "simple";
            EnvironmentFile = config.age.secrets.taskwarrior_env.path;
            ExecStart = "${taskwarrior-notifier}/bin/taskwarrior-notify-due";
          };
        };
      };

    timers =
      (
        if opts.taskwarrior.sync == null then
          { }
        else
          {
            taskwarrior-sync-timers = {
              Unit = {
                Description = "Timer for Taskwarrior3 (TaskChampion) Sync Service";
              };
              Timer = {
                OnBootSec = "5min";
                OnUnitActiveSec = opts.taskwarrior.sync.frequency;
                Unit = "taskwarrior-sync.service";
              };
              Install = {
                WantedBy = [ "timers.target" ];
              };
            };
          }
      )
      // {
        taskwarrior-notify-timers = {
          Unit = {
            Description = "Notifier for Taskwarrior3 Service";
          };
          Timer = {
            OnBootSec = "15min";
            OnUnitActiveSec = opts.taskwarrior.notifications.frequency;
            Unit = "taskwarrior-notify.service";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
  };
}
