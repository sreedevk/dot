{ config, lib, pkgs, secrets, opts, ... }: {

  virtualisation.oci-containers.containers = {
    "jellyseer" = {
      autoStart = true;
      image = "fallenbagel/jellyseerr:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/jellyseer/:/app/config" ];
      ports = [ "5055:5055" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
