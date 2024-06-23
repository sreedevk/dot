{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "archivebox" = {
      autoStart = true;
      image = "archivebox/archivebox";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.archivebox.app_port}:8000" ];
      volumes = [ "${opts.paths.application_data}/archivebox:/data" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
