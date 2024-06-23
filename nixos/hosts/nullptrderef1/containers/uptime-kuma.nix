{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    # Service Health Monitoring
    "uptime-kuma" = {
      autoStart = true;
      image = "louislam/uptime-kuma:1";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/uptime-kuma/:/app/data" ];
      ports = [ "3001:3001" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
