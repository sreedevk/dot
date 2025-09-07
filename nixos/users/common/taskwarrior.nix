{ pkgs, config, ... }:
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

  taskwarrior-tui-taskopenscript = pkgs.writeShellScriptBin "tt-taskopen" ''
    taskopen $@
  '';

  taskwarrior-notifier = pkgs.writeShellScriptBin "taskwarrior-notify-due" ''
    export DISPLAY=:1
    now=$(date +%s)
    in_one_hour=$(date -d "+1 hour" +%s)
    tasks_due_today=$(task due:today -ACTIVE _ids)
    tasks_due_soon=""
    for task_id in $tasks_due_today; do
    	task_due_date="$(task _get $task_id.due)"
    	task_due_epoch="$(date -d "$task_due_date" +%s)"
    	task_description="$(task _get $task_id.description)"
    	if [ "$task_due_epoch" -gt "$now" ] && [ "$task_due_epoch" -le "$in_one_hour" ]; then
    		tasks_due_soon+="$task_id: $task_description"$'\n'
    	fi
    done
    if [ -n "$tasks_due_soon" ]; then
    	notify-send -a "taskwarrior" -u critical -c tasks -w 'You have tasks due in the next hour:'$'\n'"$tasks_due_soon"
    fi
  '';

  taskwarriorSettings = {
    theme = "${taskwarriorOptions.themes.solarized-dark}.theme";
    clientSyncFreq = "30min";
    notificationFreq = "4m";
    dataLocation = "~/.task/";
    hooksLocation = "~/.task/hooks";

    sync = {
      serverAddress = "https://tasks.nullptr.sh";
      clientID = "$TASKWARRIOR_CLIENT_ID";
      encryptionSecret = "$TASKWARRIOR_ENCRYPTION_SECRET";
    };

    coefficients = {
      user = {
        tags = [
          {
            name = "important";
            coefficient = 15.0;
          }
        ];
        projects = [
          {
            name = "learn:tech";
            coefficient = 5.0;
          }
          {
            name = "blog";
            coefficient = 5.0;
          }
          {
            name = "opensource";
            coefficient = 5.0;
          }
          {
            name = "personal:homenet";
            coefficient = 5.0;
          }
          {
            name = "work";
            coefficient = 8.0;
          }
          {
            name = "other";
            coefficient = 4.0;
          }
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

  mkTaskConfig =
    configs:
    let
      mkprojectCoefficients =
        projectCoefficients:
        builtins.concatStringsSep "\n" (
          builtins.map (
            project: "urgency.user.project.${project.name}.coefficient=${builtins.toString project.coefficient}"
          ) projectCoefficients
        );

      mktagCoefficients =
        tagCoefficients:
        builtins.concatStringsSep "\n" (
          builtins.map (
            tag: "urgency.user.tag.${tag.name}.coefficient=${builtins.toString tag.coefficient}"
          ) tagCoefficients
        );
    in
    ''
      # THEME
      include ${configs.theme}

      # LOCAL DATA STORAGE
      data.location=${configs.dataLocation}
      hooks.location=${configs.hooksLocation}

      # SYNC SETTINGS
      sync.server.url=${configs.sync.serverAddress}
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
      uda.taskwarrior-tui.shortcuts.1=${taskwarrior-tui-taskopenscript}/bin/tt-taskopen
      ${mkprojectCoefficients configs.coefficients.user.projects}
      ${mktagCoefficients configs.coefficients.user.tags}
    '';
in
{

  home.packages = with pkgs; [
    taskwarrior3
    taskwarrior-tui
  ];

  home.file = {

    ".taskrc" = {
      enable = true;
      text = mkTaskConfig taskwarriorSettings;
      recursive = false;
    };

    ".taskopenrc" = {
      enable = true;
      text = ''
        [General]
        taskbin             = task
        taskargs
        no_annotation_hook  = "addnote $ID"
        task_attributes     = "priority,project,tags,description"
        --sort:"urgency-,annot"
        EDITOR = nvim
        path_ext=/usr/share/taskopen/scripts

        [Actions]
        files.target=annotations
        files.labelregex=".*"
        files.regex="^[\\.\\/~]+.*\\.(.*)"
        files.command="$EDITOR $FILE"
        files.modes="batch,any,normal"

        notes.target=annotations
        notes.labelregex=".*"
        notes.regex="^Notes(\\..*)?"
        notes.command="""editnote ~/Data/notebook/tasknotes/$UUID$LAST_MATCH "$TASK_DESCRIPTION" $UUID"""
        notes.modes="batch,any,normal"

        url.target=annotations
        url.labelregex=".*"
        url.regex="((?:www|http|https).*)"
        url.command="xdg-open $LAST_MATCH"
        url.modes="batch,any,normal"
      '';
    };
  };

  systemd.user = {
    services = {
      taskwarrior-sync = {
        Unit = {
          Description = "Taskwarrior3 Taskchampion Sync Job";
          Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
        };
        Service = {
          Type = "simple";
          EnvironmentFile = config.age.secrets.taskwarrior_env.path;
          ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
        };
      };

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

    timers = {
      taskwarrior-notify-timers = {
        Unit = {
          Description = "Notifier for Taskwarrior3 Service";
        };
        Timer = {
          OnBootSec = "15min";
          OnUnitActiveSec = taskwarriorSettings.notificationFreq;
          Unit = "taskwarrior-notify.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
      taskwarrior-sync-timers = {
        Unit = {
          Description = "Timer for Taskwarrior3 (TaskChampion) Sync Service";
        };
        Timer = {
          OnBootSec = "5min";
          OnUnitActiveSec = taskwarriorSettings.clientSyncFreq;
          Unit = "taskwarrior-sync.service";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
