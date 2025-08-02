{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    vdirsyncer
  ];

  services.vdirsyncer = {
    enable = true;
    frequency = "*-*-* *:00:00";
  };

  home.file = {
    ".config/vdirsyncer/config" = {
      enable = true;
      text = ''
        [general]
        status_path = "~/.config/vdirsyncer/status/"

        [pair cal_station_technica]
        a = "calendar_remote_devtechnica"
        b = "calendar_local_devstation"
        conflict_resolution = "a wins"
        collections = ["from a", "from b"]
        metadata = ["displayname", "color"]

        [storage calendar_local_devstation]
        type = "filesystem"
        path = "~/.calendars/"
        fileext = ".ics"

        [storage calendar_remote_devtechnica]
        type = "caldav"
        url = "https://cal.sree.dev/dav.php/calendars/sreedev/default/"
        username = "sreedev"
        password.fetch = ["command", "cat", "${config.age.secrets.baikal_user_password.path}"]
      '';
    };
  };
}
