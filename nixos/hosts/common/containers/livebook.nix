{ config, lib, pkgs, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "livebook" = {
      autoStart = true;
      image = "ghcr.io/livebook-dev/livebook";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "8090:8080" "8091:8081" ];
      volumes = [ "${opts.paths.application_data}/livebook:/data" ];
      environmentFiles = [ config.age.secrets.livebook_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
