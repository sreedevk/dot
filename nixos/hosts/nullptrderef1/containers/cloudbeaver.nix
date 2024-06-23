{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "cloudbeaver" = {
      autoStart = true;
      image = "dbeaver/cloudbeaver:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "8079:8978" ];
      volumes = [
        "${opts.paths.application_data}/cloudbeaver:/opt/cloudbeaver/workspace"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
