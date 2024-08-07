{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    actual-app = {
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
      image = "docker.io/actualbudget/actual-server:latest";
      ports = [
        "${opts.ports.actual-app}:5006"
      ];
      volumes = [
        "${opts.paths.application_data}/actual:/data"
      ];
    };
  };
}
