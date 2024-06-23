{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "navidrome" = {
      autoStart = true;
      image = "deluan/navidrome:latest";
      ports = [ "4533:4533" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/navidrome"
        "${opts.paths.music}:/music:ro"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        ND_SCANSCHEDULE = "1h";
        ND_LOGLEVEL = "info";
        ND_SESSIONTIMEOUT = "24h";
        ND_BASEURL = "";
      };
    };
  };
}
