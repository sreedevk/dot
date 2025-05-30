{ opts, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/recyclarr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    recyclarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "recyclarr/recyclarr:latest";
      dependsOn = [
        "sonarr"
        "radarr"
      ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.app_datafiles}/recyclarr:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
