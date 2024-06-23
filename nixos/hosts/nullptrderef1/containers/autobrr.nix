{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "autobrr" = {
      autoStart = true;
      image = "ghcr.io/autobrr/autobrr:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "qbittorrent-nox" ];
      ports = [ "${opts.apps.autobrr.app_port}:7474" ];
      volumes = [ "${opts.paths.application_data}/autobrr/:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
