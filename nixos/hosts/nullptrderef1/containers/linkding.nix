{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "linkding" = {
      autoStart = true;
      image = "sissbruecker/linkding:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "${opts.paths.application_data}/Linkding:/etc/linkding/data" ];
      ports = [ "9090:9090" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
