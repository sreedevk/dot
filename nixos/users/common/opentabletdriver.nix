{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opentabletdriver
  ];

  systemd.user =
    {
      services = {
        opentabletdriver = {
          Unit = {
            Description = "OpenTabletDriver Daemon";
            PartOf = "graphical-session.target";
            After = "graphical-session.target";
          };
          Service = {
            ExecStart = "${pkgs.opentabletdriver}/bin/otd-daemon";
            Restart = "always";
            RestartSec = 3;
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
}
