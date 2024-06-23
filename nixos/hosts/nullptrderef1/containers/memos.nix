{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "memos" = {
      autoStart = true;
      ports = [ "${opts.apps.memos.app_port}:5230" ];
      image = "neosmemo/memos:stable";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Memos:/var/opt/memos"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
