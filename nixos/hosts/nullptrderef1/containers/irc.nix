{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "znc" = {
      autoStart = true;
      image = "lscr.io/linuxserver/znc:latest";
      ports = [ "${opts.apps.znc.app_port}:6501" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/znc/:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "thelounge" = {
      autoStart = true;
      image = "ghcr.io/thelounge/thelounge:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.thelounge.app_port}:9000" ];
      volumes =
        [ "${opts.paths.application_data}/thelounge:/var/opt/thelounge" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
