{
  pkgs,
  config,
  opts,
  ...
}:
let
  themes = import ./theme.nix;
  theme = "${themes.solarized-dark}.theme";
  taskwarrior-notifier = import ../scripts/taskwarrior-notify.nix { inherit pkgs; };
  utils = import ./utils.nix;
  coefficients = import ./coefficients.nix;
  taskConfig = utils.mkConfig theme opts coefficients;
in
{

  home = {
    packages = with pkgs; [
      taskwarrior3
      taskwarrior-tui
    ];

    sessionVariables =
      with builtins;
      if opts.taskwarrior.sync == null then
        { }
      else
        {
          TASKWARRIOR_CLIENT_ID = "$(cat ${(getAttr "taskwarrior_client_id" config.age.secrets).path})";
          TASKWARRIOR_ENCRYPTION_SECRET = "$(cat ${(getAttr "taskwarrior_encryption_secret" config.age.secrets).path})";
        };

    file = {
      ".taskrc" = {
        enable = true;
        text = taskConfig;
        recursive = false;
      };
    };
  };

  systemd.user.sessionVariables =
    with builtins;
    if opts.taskwarrior.sync == null then
      { }
    else
      {
        TASKWARRIOR_CLIENT_ID = "$(cat ${(getAttr "taskwarrior_client_id" config.age.secrets).path})";
        TASKWARRIOR_ENCRYPTION_SECRET = "$(cat ${(getAttr "taskwarrior_encryption_secret" config.age.secrets).path})";
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
                ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
                RemainAfterExit = true;
              }
              // (
                if config.age.secrets ? taskwarrior_env then
                  {
                    EnvironmentFile = (builtins.getAttr "taskwarrior_env" config.age.secrets).path;
                  }
                else
                  { }
              );
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
            ExecStart = "${taskwarrior-notifier}/bin/taskwarrior-notify-due";
          }
          // (
            if config.age.secrets ? taskwarrior_env then
              {
                EnvironmentFile = (builtins.getAttr "taskwarrior_env" config.age.secrets).path;
              }
            else
              { }
          );
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
