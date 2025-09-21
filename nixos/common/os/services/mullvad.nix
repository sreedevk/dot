{ config, ... }:
{
  services.mullvad-vpn = {
    enable = true;
  };

  systemd.timers."mullvad-reconnect" = {
    wantedBy = [ "timers.target" ];
    partOf = [ "mullvad-daemon.service" ];
    after = [ "mullvad-daemon.service" ];
    timerConfig = {
      OnUnitActiveSec = "3h";
      OnBootSec = "10min";
      Unit = "mullvad-reconnect.service";
    };
  };

  systemd.services."mullvad-reconnect" = {
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "${config.services.mullvad-vpn.package}/bin/mullvad reconnect";
    };
    partOf = [ "mullvad-daemon.service" ];
    after = [ "mullvad-daemon.service" ];
  };

  systemd.services."mullvad-daemon".postStart =
    let
      mullvad = config.services.mullvad-vpn.package;
    in
    ''
      while ! ${mullvad}/bin/mullvad status > /dev/null; do sleep 1; done
      ${mullvad}/bin/mullvad account get | grep "Not logged in" && ${mullvad}/bin/mullvad account login $(cat ${config.age.secrets.vpn-acc.path})
      ${mullvad}/bin/mullvad relay set location $(cat ${config.age.secrets.vpn-loc.path})
      ${mullvad}/bin/mullvad lockdown-mode set on
      ${mullvad}/bin/mullvad lan set allow
      ${mullvad}/bin/mullvad tunnel set ipv6 off
      ${mullvad}/bin/mullvad dns set custom "127.0.0.1" "9.9.9.9"
      ${mullvad}/bin/mullvad auto-connect set on
    '';
}
