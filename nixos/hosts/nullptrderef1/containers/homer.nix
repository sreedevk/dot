{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "homer" = {
      autoStart = true;
      image = "b4bz/homer:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/homer/:/www/assets" ];
      ports = [ "${opts.apps.homer.app_port}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
