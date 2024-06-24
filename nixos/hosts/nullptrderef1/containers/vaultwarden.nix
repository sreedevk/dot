{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "vaultwarden" = {
      autoStart = true;
      image = "vaultwarden/server:latest ";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.vaultwarden.app_port}:80" ];
      volumes = [ "${opts.paths.application_data}/vw-data:/data/" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
