{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "plex" = {
      autoStart = true;
      image = "plexinc/pms-docker";
      extraOptions = [ "--network=host" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/plex/database/:/config"
        "${opts.paths.application_data}/plex/transcode/:/transcode"
      ];
      ports = [ "${opts.ports.plex}:32400" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        PLEX_CLAIM = secrets.plex_app_claim;
      };
    };
  };
}
