{ pkgs, ... }:
{
  home.packages = with pkgs; [ vicinae ];

  systemd.user.services = {
    vicinae-server = {
      Unit = {
        Description = "Vicinae Launcher Server";
        Documentation = "info:vicinae https://docs.vicinae.com";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.vicinae}/bin/vicinae server";
        Restart = "always";
        RestartSec = 3;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
