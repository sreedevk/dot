{ username, ... }:
{
  systemd.user.services = {
    web = {
      Unit = {
        Description = "Devtechnica Web";
      };
      Service = {
        WorkingDirectory = "/home/${username}/www";
        Type = "simple";
        ExecStart = "/usr/bin/docker compose up";
        ExecStop = "/usr/bin/docker compose down";
        Restart = "always";
        RestartSec = 1;
        TimeoutStartSec = 0;
        RemainAfterExit = "yes";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
