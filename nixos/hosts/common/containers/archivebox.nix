{ config, lib, pkgs, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "archivebox" = {
      autoStart = true;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "archivebox/archivebox";
      ports = [
        "${opts.ports.archivebox}:8000"
      ];
      volumes = [
        "${opts.paths.application_data}/archivebox:/data"
      ];
    };
  };
}
