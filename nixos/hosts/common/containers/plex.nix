{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ plex tautulli ]);

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
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.plex.http.parent_name" = "${opts.hostname}";
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

    tautulli = {
      autoStart = true;
      dependsOn = [ "plex" ];
      image = "ghcr.io/tautulli/tautulli";
      extraOptions = [ "--no-healthcheck" "--network=host" ];
      volumes = [ "${opts.paths.application_data}/Tautulli:/config" ];
      ports = [ "${opts.ports.tautulli}:8181" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

  };
}
