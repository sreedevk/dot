{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ navidrome ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/navidrome 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "navidrome" = {
      autoStart = true;
      image = "deluan/navidrome:latest";
      ports = [ "${opts.ports.navidrome}:4533" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/navidrome:/data"
        "${opts.paths.music}:/music:ro"
        "${opts.paths.podcasts}:/podcasts:ro"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        ND_SCANSCHEDULE = "1h";
        ND_LOGLEVEL = "info";
        ND_SESSIONTIMEOUT = "24h";
        ND_BASEURL = "https://music.nullptr.sh";
      };
    };
  };
}
