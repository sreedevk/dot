{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "huginn" = {
      autoStart = true;
      image = "ghcr.io/huginn/huginn";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.huginn}:3000" ];
      volumes = [ "${opts.paths.application_databases}/huginn:/var/lib/mysql" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
