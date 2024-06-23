{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "docuseal" = {
      autoStart = true;
      image = "docuseal/docuseal";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.docuseal.app_port}:3000" ];
      volumes = [ "${opts.paths.application_data}/docuseal:/data" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
