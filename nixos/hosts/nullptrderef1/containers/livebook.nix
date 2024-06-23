{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "livebook" = {
      autoStart = true;
      image = "ghcr.io/livebook-dev/livebook";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "8090:8080" "8091:8081" ];
      volumes = [ "${opts.paths.application_data}/livebook:/data" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        LIVEBOOK_PASSWORD = secrets.livebook.password;
      };
    };
  };
}
