{ pkgs, secrets, ... }:
{
  systemd.user = {
    enable = true;
    services = {
      emacs = {
        Unit = {
          Description = "Emacs text editor";
          Documentation = "info:emacs man:emacs(1) https://gnu.org/software/emacs/";
        };
        Service = {
          Type = "forking";
          ExecStart = "/usr/bin/emacs --daemon";
          ExecStop = "/usr/bin/emacsclient --eval \"(kill-emacs)\"";
          Environment = "SSH_AUTH_SOCK=%t/keyring/ssh";
          Restart = "on-failure";
        };
      };

      taskwarrior-sync = {
        Unit = {
          Description = "Taskwarrior3 Taskchampion Sync Job";
          Documentation = "info:task man:task(1) https://taskwarrior.org/docs/";
        };
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.taskwarrior3}/bin/task sync";
          Restart = "on-failure";
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
