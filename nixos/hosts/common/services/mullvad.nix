{ config, secrets, ... }: {
  services.mullvad-vpn = { enable = true; };

  systemd.services."mullvad-daemon".postStart =
    let mullvad = config.services.mullvad-vpn.package;
    in ''
      while ! ${mullvad}/bin/mullvad status > /dev/null; do sleep 1; done
      ${mullvad}/bin/mullvad account get | grep "Not logged in" && ${mullvad}/bin/mullvad account login ${secrets.mullvad_account or ""}
      ${mullvad}/bin/mullvad relay set location ${secrets.mullvad_location or ""}
      ${mullvad}/bin/mullvad lockdown-mode set on
      ${mullvad}/bin/mullvad lan set allow
      ${mullvad}/bin/mullvad tunnel set ipv6 off
      ${mullvad}/bin/mullvad dns set custom "127.0.0.1" "9.9.9.9"
      ${mullvad}/bin/mullvad auto-connect set on
    '';
}
