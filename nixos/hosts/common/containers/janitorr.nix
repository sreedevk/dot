{ opts, ... }:
{

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/janitorr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

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
        "${opts.paths.app_datafiles}/janitorr:/config"
        "${opts.paths.movies}:/data/movies"
        "${opts.paths.television}:/data/television"
      ];
    };
  };
}
