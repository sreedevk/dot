{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "radarr" = {
      autoStart = true;
      image = "ghcr.io/hotio/radarr";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "qbittorrent-nox" ];
      volumes = [
        "${opts.paths.application_data}/Radarr/:/config"
        "${opts.paths.movies}:/movies"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.apps.radarr.app_port}:7878" ];
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
      dependsOn = [ "qbittorrent-nox" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Sonarr/:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.apps.sonarr.app_port}:8989" ];
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
      dependsOn = [ "qbittorrent-nox" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Lidarr/:/config"
        "${opts.paths.music}:/music"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "8686:8686" ];
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
      dependsOn = [ "qbittorrent-nox" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/Readarr/:/config"
        "${opts.paths.books}:/books"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.apps.readarr.app_port}:8787" ];
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
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.bazarr.app_port}:6767" ];
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
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "flareSolverr" ];
      volumes = [
        "${opts.paths.application_data}/Prowlarr/:/config"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "9696:9696" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
