{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ plex ]);
  virtualisation.oci-containers.containers = {
    "plex" = {
      autoStart = true;
      image = "plexinc/pms-docker";
      extraOptions = [ "--network=host" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/plex/database/:/config"
        "${opts.paths.application_data}/plex/transcode/:/transcode"
        "${opts.paths.movies}:/movies"
        "${opts.paths.television}:/television"
        "${opts.paths.music}:/music"
      ];
      ports = [ "${opts.ports.plex}:32400" ];
      labels = {
        "kuma.plex.http.name" = "Plex Media Server";
        "kuma.plex.http.url" = "http://${opts.lanAddress}:${opts.ports.plex}/identity";
      };
      environmentFiles = [ config.age.secrets.plex_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
