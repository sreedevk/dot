{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bazarr lidarr prowlarr radarr readarr sonarr ]);
  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads} 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/recyclarr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  environment.etc = {
    "flemmarr/config.yml" = {
      enable = true;
      text =
        builtins.toJSON {
          sonarr = {
            address = opts.hostname;
            port = opts.ports.sonarr;
            config = {
              naming = {
                renameEpisodes = true;
                replaceIllegalCharacters = true;
                multiEpisodeStyle = 5;
                seriesFolderFormat = "{Series TitleYear} [imdb-{ImdbId}]";
                seasonFolderFormat = "Season {season:00}";
                specialsFolderFormat = "Specials";
                includeSeriesTitle = false;
                includeEpisodeTitle = false;
                includeQuality = false;
                replaceSpaces = true;
                separator = " - ";
                numberStyle = "S{season:00}E{episode:00}";
              };
              mediamanagement = {
                autoUnmonitorPreviouslyDownloadedEpisodes = false;
                recycleBin = "";
                recycleBinCleanupDays = 7;
                downloadPropersAndRepacks = "doNotUpgrade";
                createEmptySeriesFolders = false;
                deleteEmptyFolders = false;
                fileDate = "none";
                rescanAfterRefresh = "always";
                setPermissionsLinux = false;
                chmodFolder = "755";
                chownGroup = "";
                episodeTitleRequired = "always";
                skipFreeSpaceCheckWhenImporting = true;
                minimumFreeSpaceWhenImporting = 100;
                copyUsingHardlinks = true;
                importExtraFiles = true;
                extraFileExtensions = "srt";
                enableMediaInfo = true;
              };
              host = { analyticsEnabled = false; };
              ui = { firstDayOfWeek = 1; timeFormat = "h(:mm)a"; };
              rootfolder = [
                {
                  name = "Series";
                  path = "/tv";
                  defaultTags = [ ];
                  defaultQualityProfileId = 1;
                  defaultMetadataProfileId = 1;
                }
              ];
              downloadclient = [
                {
                  name = "qBittorrent";
                  enable = true;
                  protocol = "torrent";
                  priority = 2;
                  removeCompletedDownloads = true;
                  removeFailedDownloads = true;
                  fields = [
                    { name = "host"; value = "nullptrderef1"; }
                    { name = "port"; value = 8001; }
                    { name = "username"; value = "admin"; }
                    { name = "password"; value = "changeme"; }
                    { name = "tvCategory"; value = "Sonarr"; }
                  ];
                  implementation = "QBittorrent";
                  configContract = "QBittorrentSettings";
                }
              ];
            };
          };
        };
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
      autoStart = opts.autostart-non-essential-services;
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
      autoStart = opts.autostart-non-essential-services;
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
      autoStart = opts.autostart-non-essential-services;
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
      autoStart = opts.autostart-non-essential-services;
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
      autoStart = opts.autostart-non-essential-services;
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

    kapowarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "mrcas/kapowarr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "kapowarr_db:/app/db"
        "${opts.paths.downloads}:/app/temp_downloads"
        "${opts.paths.comics}:/comics"
      ];
      ports = [ "${opts.ports.kapowarr}:5656" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    bazarr = {
      autoStart = opts.autostart-non-essential-services;
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
      autoStart = opts.autostart-non-essential-services;
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
