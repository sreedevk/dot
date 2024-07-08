{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    actual-app = {
      autoStart = true;
      image = "actual-server:latest";
      ports = [ "${opts.ports.actual-app}:5006" ];
      volumes = [ "${opts.paths.application_data}/actual:/data" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
