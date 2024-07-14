{ pkgs, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    "watchtower" = {
      autoStart = true;
      image = "containrrr/watchtower";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.podmanSocket}:/var/run/docker.sock" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };

}
