{ config, lib, pkgs, secrets, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bazarr lidarr prowlarr radarr readarr sonarr ]);

  virtualisation.oci-containers.containers = {
    "radarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/radarr";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Radarr/:/config"
        "${opts.paths.movies}:/movies"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.radarr}:7878" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    # Sonarr TV Indexer
    "sonarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/sonarr";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Sonarr/:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.sonarr}:8989" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    # Lidarr Music Indexer
    "lidarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/lidarr";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Lidarr/:/config"
        "${opts.paths.music}:/music"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.lidarr}:8686" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    # Readarr Books Indexer
    "readarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/readarr";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Readarr/:/config"
        "${opts.paths.books}:/books"
        "${opts.paths.audiobooks}:/audiobooks"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.readarr}:8787" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "bazarr" = {
      autoStart = true;
      image = "lscr.io/linuxserver/bazarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.bazarr}:6767" ];
      volumes = [
        "${opts.paths.application_data}/Bazarr/config:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.movies}:/movies"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "prowlarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/prowlarr";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "flareSolverr" ];
      volumes = [
        "${opts.paths.application_data}/Prowlarr/:/config"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.prowlarr}:9696" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
