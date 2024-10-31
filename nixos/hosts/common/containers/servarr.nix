{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bazarr lidarr prowlarr radarr readarr sonarr ]);
  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads} 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/recyclarr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];


  environment.etc = {
    "flemmarr/config.yml" = {
      enable = true;
      text = ''
        sonarr:
          address: sonarr
          port: 8989
          config:
            host:
              analyticsEnabled: false
            ui:
              firstDayOfWeek: 1 # 0 = Sunday, 1 = Monday
              timeFormat: HH:mm # HH:mm = 17:30, h(:mm)a = 5:30PM
            rootfolder:
                - name: Series
                  path: /tv
                  defaultTags: []
                  defaultQualityProfileId: 1
                  defaultMetadataProfileId: 1
            downloadclient:
                - name: qBittorrent
                  enable: true
                  protocol: torrent
                  priority: 2
                  removeCompletedDownloads: true
                  removeFailedDownloads: true
                  fields:
                  - name: host
                    value: nullptrderef1
                  - name: port
                    value: 8001
                  - name: username
                    value: admin
                  - name: password
                    value: changeme
                  - name: tvCategory
                    value: Sonarr
                  implementation: QBittorrent
                  configContract: QBittorrentSettings
      '';
    };
  };

  virtualisation.oci-containers.containers = {
    flemmarr = {
      autoStart = false;
      image = "pierremesure/flemmarr";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "sonarr" "radarr" "readarr" "lidarr" ];
      volumes = [ "/etc/flemmarr:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    recyclarr = {
      autoStart = true;
      image = "recyclarr/recyclarr:latest";
      dependsOn = [
        "sonarr"
        "radarr"
      ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.app_datafiles}/recyclarr:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    radarr = {
      autoStart = true;
      image = "hotio/radarr:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "radarr_data:/config"
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
    sonarr = {
      autoStart = true;
      image = "hotio/sonarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "sonarr_data:/config"
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
    lidarr = {
      autoStart = true;
      image = "hotio/lidarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "lidarr_data:/config"
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
    readarr = {
      autoStart = true;
      image = "hotio/readarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "readarr_data:/config"
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

    bazarr = {
      autoStart = true;
      image = "hotio/bazarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.bazarr}:6767" ];
      volumes = [
        "bazarr_data:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.movies}:/movies"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    prowlarr = {
      autoStart = true;
      image = "hotio/prowlarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "flareSolverr" ];
      volumes = [
        "prowlarr_data:/config"
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
