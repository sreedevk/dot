{ pkgs, secrets, ... }:
let
  taskwarriorOptions = {
    themes = {
      dark-16 = "dark-16";
      dark = "dark-256";
      dark-blue = "dark-blue-256";
      dark-gray = "dark-gray-256";
      dark-gray-blue = "dark-gray-blue-256";
      dark-green = "dark-green-256";
      dark-red = "dark-red-256";
      dark-yellow-green = "dark-yellow-green";
      light-16 = "light-16";
      light = "light-256";
      nocolor = "no-color";
      solarized-dark = "solarized-dark-256";
    };
  };

  taskwarriorSettings = {
    theme = "${taskwarriorOptions.themes.solarized-dark}.theme";

    dataLocation = "~/.task/";
    hooksLocation = "~/.task/hooks";

    sync = {
      serverAddress = "http://nullptrderef1:8080";
      clientID = secrets.taskwarrior.client_id;
      encryptionSecret = secrets.taskwarrior.encryption_secret;
    };

    coefficients = {
      user = {
        tags = [
          { name = "important"; coefficient = 15.0; }
        ];
        projects = [
          { name = "learn:tech"; coefficient = 5.0; }
          { name = "blog"; coefficient = 5.0; }
          { name = "opensource"; coefficient = 5.0; }
          { name = "personal:homenet"; coefficient = 5.0; }
          { name = "work"; coefficient = 8.0; }
          { name = "other"; coefficient = 4.0; }
        ];
      };

      system = {
        due = 12.0;
        blocking = 2.0;
        scheduled = 5.0;
        active = 4.0;
        age = 2.0;
        annotations = 1.0;
        tags = 1.0;
        project = 1.0;
        waiting = -3.0;
        blocked = -5.0;
      };
      uda = {
        H = 6.0;
        M = 3.9;
        L = 1.8;
      };
    };
  };

  mkTaskConfig = configs:
    let
      mkprojectCoefficients = projectCoefficients: builtins.concatStringsSep
        "\n"
        (builtins.map
          (project: "urgency.user.project.${project.name}.coefficient=${builtins.toString project.coefficient}")
          projectCoefficients);

      mktagCoefficients = tagCoefficients: builtins.concatStringsSep
        "\n"
        (builtins.map
          (tag: "urgency.user.tag.${tag.name}.coefficient=${builtins.toString tag.coefficient}")
          tagCoefficients);
    in
    ''
      # THEME
      include ${configs.theme}

      # LOCAL DATA STORAGE
      data.location=${configs.dataLocation}
      hooks.location=${configs.hooksLocation}

      # SYNC SETTINGS
      sync.server.origin=${configs.sync.serverAddress}
      sync.server.client_id=${configs.sync.clientID}
      sync.encryption_secret=${configs.sync.encryptionSecret}

      # COEFFICIENTS
      urgency.due.coefficient=${builtins.toString configs.coefficients.system.due}
      urgency.blocking.coefficient=${builtins.toString configs.coefficients.system.blocking}
      urgency.scheduled.coefficient=${builtins.toString configs.coefficients.system.scheduled}
      urgency.active.coefficient=${builtins.toString configs.coefficients.system.active}
      urgency.age.coefficient=${builtins.toString configs.coefficients.system.age}
      urgency.annotations.coefficient=${builtins.toString configs.coefficients.system.annotations}
      urgency.waiting.coefficient=${builtins.toString configs.coefficients.system.waiting}
      urgency.blocked.coefficient=${builtins.toString configs.coefficients.system.blocked}
      urgency.tags.coefficient=${builtins.toString configs.coefficients.system.tags}
      urgency.project.coefficient=${builtins.toString configs.coefficients.system.project}
      urgency.uda.priority.H.coefficient=${builtins.toString configs.coefficients.uda.H}
      urgency.uda.priority.M.coefficient=${builtins.toString configs.coefficients.uda.M}
      urgency.uda.priority.L.coefficient=${builtins.toString configs.coefficients.uda.L}
      ${mkprojectCoefficients configs.coefficients.user.projects}
      ${mktagCoefficients configs.coefficients.user.tags}
    '';
in
{
  home.file = {
    ".taskrc" = {
      enable = true;
      text = mkTaskConfig taskwarriorSettings;
      recursive = false;
    };
  };

  systemd.user =
    {
      services = {
        taskwarrior-sync = {
          Unit = {
            Description = "Taskwarrior3 Taskchampion Sync Job";
            Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
          };
          Service = {
            Type = "simple";
            ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
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
            Unit = "taskwarrior-sync.service";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}
