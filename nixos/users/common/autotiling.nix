{ pkgs, lib, inputs, system, ... }: {
  systemd.user.services = {
    autotiling = {
      Unit = {
        Description = "xorg based window manager autotiling service";
        Documentation = "https://github.com/nwg-piotr/autotiling";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.autotiling}/bin/autotiling";
        Restart = "always";
        RestartSec = 3;
        StartLimitInterval = 0;
        StartLimitBurst = 0;
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
