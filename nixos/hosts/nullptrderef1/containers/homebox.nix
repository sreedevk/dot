{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "homebox" = {
      autoStart = true;
      image = "ghcr.io/hay-kot/homebox:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "3100:7745" ];
      volumes = [ "${opts.paths.application_data}/HomeBox:/data" ];
      environment = {
        HBOX_LOG_LEVEL = "info";
        HBOX_LOG_FORMAT = "text";
        HBOX_WEB_MAX_UPLOAD_SIZE = "10";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
