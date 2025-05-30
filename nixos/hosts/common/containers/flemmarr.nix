{ opts, ... }:
{
  # Containers
  virtualisation.oci-containers.containers = {
    flemmarr = {
      autoStart = false;
      image = "pierremesure/flemmarr";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [
        "sonarr"
        "radarr"
        "readarr"
        "lidarr"
      ];
      volumes = [ "/etc/flemmarr:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };

  # Configuration
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
}
