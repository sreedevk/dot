{ config, pkgs, secrets, ... }: {
  systemd.services.radio-streaming = {
    description = "enable audio streaming from XHDATA D-328 Radio";
    enable = true;
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart =
        "${pkgs.ffmpeg}/bin/ffmpeg -f alsa -ac 2 -ar 44100 -i hw:0 -acodec libmp3lame -b:a 128k -content_type audio/mpeg -f mp3 icecast://radiosource:${secrets.icecast.password}@0.0.0.0:8099/radio";
      Restart = "always";
    };
  };

  services.icecast = {
    enable = true;
    hostname = "nullptrderef1";
    listen = {
      address = "0.0.0.0";
      port = 8099;
    };
    admin = {
      user = "admin";
      password = secrets.icecast.password;
    };
    extraConf = ''
      <authentication>
         <source-password>${secrets.icecast.password}</source-password>
         <relay-user>relay</relay-user>
         <relay-password>${secrets.icecast.password}</relay-password>
         <admin-user>admin</admin-user>
         <admin-password>${secrets.icecast.password}</admin-password>
      </authentication>
      <mount type="normal">
        <mount-name>/radio</mount-name>
        <username>radiosource</username>
        <password>${secrets.icecast.password}</password>
        <dump-file>/tmp/dump-example1.ogg</dump-file>
        <stream-name>New York City Radio Stream</stream-name>
      </mount>
    '';
  };
}