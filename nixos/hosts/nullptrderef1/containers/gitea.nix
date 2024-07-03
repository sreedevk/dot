{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "gitea" = {
      autoStart = true;
      image = "gitea/gitea:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.application_data}/gitea:/data"
      ];
      ports = [
        "${opts.ports.gitea_http}:3000"
        "${opts.ports.gitea_ssh}:22"
      ];
    };
  };
}
