{ opts, ... }:
{
  virtualisation.oci-containers.containers = {
    janitorr = {
      autoStart = true;
      image = "ghcr.io/schaka/janitorr:stable";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.application_data}/Janitorr:/config"
        "${opts.paths.movies}:/data/movies"
        "${opts.paths.television}:/data/television"
      ];
    };
  };
}
