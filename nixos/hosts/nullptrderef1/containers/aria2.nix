{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "aria2" = {
      autoStart = true;
      image = "hurlenko/aria2-ariang";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "6880:8080" "6800:6800" ];
      volumes = [
        "${opts.paths.downloads}/Aria2:/aria2/data"
        "${opts.paths.application_data}/aria2:/aria2/conf"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}