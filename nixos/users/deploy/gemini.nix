{ username, ... }:
{
  systemd.user.services = {
    gemini = {
      Unit = {
        Description = "Gemini Capsule Server";
      };
      Service = {
        WorkingDirectory = "/home/${username}/gemini";
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
