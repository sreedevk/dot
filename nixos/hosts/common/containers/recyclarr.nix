{ opts, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/recyclarr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    recyclarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/recyclarr/recyclarr:latest";
      dependsOn = [
        "sonarr"
        "radarr"
      ];
      user = "${opts.adminUID}:${opts.adminGID}";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "${opts.paths.app_datafiles}/recyclarr:/config" ];
      environment = {
        TZ = opts.timeZone;
        CRON_SCHEDULE = "@daily";
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        RECYCLARR_CREATE_CONFIG = "true";
      };
    };
  };
}
