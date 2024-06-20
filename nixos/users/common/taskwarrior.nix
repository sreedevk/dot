{ pkgs, secrets, ... }:
let
  taskwarriorOptions = {
    themes = {
      dark-16 = "dark-16.theme";
      dark = "dark-256.theme";
      dark-blue = "dark-blue-256.theme";
      dark-gray = "dark-gray-256.theme";
      dark-gray-blue = "dark-gray-blue-256.theme";
      dark-green = "dark-green-256.theme";
      dark-red = "dark-red-256.theme";
      dark-yellow-green = "dark-yellow-green.theme";
      light-16 = "light-16.theme";
      light = "light-256.theme";
      nocolor = "no-color.theme";
      solarized-dark = "solarized-dark-256.theme";
    };
  };

  taskwarriorSettings = {
    theme = taskwarriorOptions.themes.solarized-dark;

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
      castFloatToString = float: builtins.substring 0 3 (builtins.toString float);
      mkProjectCoefficient = project: "urgency.user.project.\"${project.name}\".coefficient ${castFloatToString project.coefficient}";
      projectCoefficients = builtins.concatStringsSep "\n" (builtins.map (mkProjectCoefficient) configs.coefficients.user.projects);
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
      sync.server.encryption_secret=${configs.sync.encryptionSecret}

      # COEFFICIENTS
      ${projectCoefficients}
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
