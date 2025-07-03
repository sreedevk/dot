{ username, ... }:
{
  systemd.user.services = {
    wosbot = {
      Unit = {
        Description = "Wosbot Server";
      };
      Service = {
        WorkingDirectory = "/home/${username}/wosbot";
        Type = "simple";
        ExecStart = "/usr/bin/docker compose up";
        ExecStop = "/usr/bin/docker compose down";
        Restart = "always";
        RestartSec = 1;
        TimeoutStartSec = 0;
        RemainAfterExit = "yes";
      };
      Install = {
        WantedBy = [ "multi-user.target" ];
      };
    };
  };
}
