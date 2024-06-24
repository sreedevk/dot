{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "jackett" = {
      autoStart = true;
      image = "lscr.io/linuxserver/jackett:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "flareSolverr" ];
      environment = {
        AUTO_UPDATE = "true";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.application_data}/Jackett:/config"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.jackett}:9117" ];
    };
  };
}
