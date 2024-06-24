{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "baikal" = {
      autoStart = true;
      image = "ckulka/baikal:nginx";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.baikal}:80" ];
      volumes = [
        "${opts.paths.application_data}/Baikal:/var/www/baikal/config"
        "${opts.paths.application_data}/Baikal:/var/www/baikal/Specific"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
