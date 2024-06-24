{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "olivetin" = {
      autoStart = true;
      image = "jamesread/olivetin";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/olivetin:/config"
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
      ];
      ports = [ "${opts.ports.olivetin}:1337" ];
      user = "root";
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
