{ config, lib, pkgs, secrets, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.oci-containers.containers =
    let
      applicationUserName = "nullptrderef1";
      lanAddress = "192.168.1.179";
      timeZone = "America/New_York";
      podmanSocket = "/var/run/podman/podman.sock";

      downloadsDir = "/mnt/data/downloads/";
      torrentsWatchDir = "/mnt/data/torrents/";

      applicationConfigDir = "/mnt/data/applications";

      moviesDir = "/mnt/data/media/movies/";
      tvDir = "/mnt/data/media/shows/";
      audioBooksDir = "/mnt/data/media/audiobooks/";
      musicDir = "/mnt/data/media/music/";
      videosDir = "/mnt/data/media/videos/";
      imagesDir = "/mnt/data/media/images/";
      booksDir = "/mnt/data/media/books/";
      magazinesDir = "/mnt/data/media/magazines/";

      encTvDir = "/mnt/enc_data_drive/media/shows/";
      encVideosDir = "/mnt/enc_data_drive/media/videos/";

      adminUID = "1000";
      adminGID = "100";
    in
    {
      # Jellyfin Media Player
      "jellyfin" = {
        autoStart = true;
        image = "jellyfin/jellyfin";
        volumes = [
          "${applicationConfigDir}/jellyfin/config:/config"
          "${applicationConfigDir}/jellyfin/cache/:/cache"
          "${applicationConfigDir}/jellyfin/log/:/log"
          "${moviesDir}:/movies"
          "${tvDir}:/tv"
          "${encTvDir}:/enctv"
          "${audioBooksDir}:/audiobooks"
          "${musicDir}:/music"
        ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8096:8096" ];
        environment = {
          JELLYFIN_LOG_DIR = "/log";
        };
      };

      # Jellyseer Media Discovery
      "jellyseer" = {
        autoStart = true;
        image = "fallenbagel/jellyseerr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/jellyseer/:/app/config"
        ];
        ports = [ "5055:5055" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Plex Media Server
      "plex" = {
        autoStart = true;
        image = "plexinc/pms-docker";
        extraOptions = [ "--network=host" ];
        volumes = [
          "${applicationConfigDir}/plex/database/:/config"
          "${applicationConfigDir}/plex/transcode/:/transcode"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          PLEX_CLAIM = secrets.plex.claim;
        };
      };

      # qBittorrent P2P Torrent Client
      "qbittorrent-nox" = {
        autoStart = true;
        image = "qbittorrentofficial/qbittorrent-nox:4.6.4-1";
        ports = [ "6881:6881/tcp" "6881:6881/udp" "8001:8001/tcp" ];
        environment = {
          QBT_EULA = "accept";
          QBT_VERSION = "4.6.4-1";
          QBT_WEBUI_PORT = "8001";
          TZ = timeZone;
          USER_UID = adminUID;
          USER_GID = adminGID;
        };
        volumes = [
          "${applicationConfigDir}/qbittorrent/config/:/config"
          "${applicationConfigDir}/vuetorrent:/vuetorrent"
          "${downloadsDir}:/downloads"
          "${torrentsWatchDir}:/torrents"
          "${imagesDir}:/images"
          "${videosDir}:/videos"
          "${booksDir}:/books"
          "${magazinesDir}:/magazines"
        ];
        extraOptions = [ "--network=host" ];
      };

      "autobrr" = {
        autoStart = true;
        image = "ghcr.io/autobrr/autobrr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "qbittorrent-nox" ];
        ports = [ "7474:7474" ];
        volumes = [
          "${applicationConfigDir}/autobrr/:/config"
        ];
        environment = {
          TZ = timeZone;
        };
      };

      #docker pull vaultwarden/server:latest
      # docker run -d --name vaultwarden -v /vw-data/:/data/ --restart unless-stopped -p 80:80 

      "vaultwarden" = {
        autoStart = true;
        image = "vaultwarden/server:latest ";
        ports = [ "9801:80" ];
        volumes = [
          "/mnt/enc_data_drive/secrets/vw-data:/data/"
        ];
      };

      "homebox" = {
        autoStart = true;
        image = "ghcr.io/hay-kot/homebox:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "3100:7745" ];
        volumes = [
          "${applicationConfigDir}/Homebox:/data"
        ];
        environment = {
          HBOX_LOG_LEVEL = "info";
          HBOX_LOG_FORMAT = "text";
          HBOX_WEB_MAX_UPLOAD_SIZE = "10";
        };
      };

      # Radarr Movies Indexer
      "radarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/radarr";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "qbittorrent-nox" ];
        volumes = [
          "${applicationConfigDir}/Radarr/:/config"
          "${moviesDir}:/movies"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "7878:7878" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Sonarr TV Indexer
      "sonarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/sonarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Sonarr/:/config"
          "${tvDir}:/tv"
          "${encTvDir}:/enctv"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8989:8989" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Lidarr Music Indexer
      "lidarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/lidarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Lidarr/:/config"
          "${musicDir}:/music"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8686:8686" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Readarr Books Indexer
      "readarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/readarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Readarr/:/config"
          "${booksDir}:/books"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8787:8787" ];
        environment = {
          TZ = timeZone;
        };
      };

      "openbooks" = {
        autoStart = true;
        image = "evanbuss/openbooks";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${booksDir}:/books"
        ];
        ports = [ "8004:80" ];
        cmd = [ "--persist" "--name='${applicationUserName}'" ];
        environment = {
          TZ = timeZone;
        };
      };

      "homarr" = {
        autoStart = true;
        image = "ghcr.io/ajnart/homarr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Homarr/config:/app/data/configs"
          "${applicationConfigDir}/Homarr/data:/data"
          "${applicationConfigDir}/Homarr/icons:/icons"
        ];
        ports = [ "7575:7575" ];
        environment = {
          TZ = timeZone;
        };
      };

      "whisparr" = {
        autoStart = true;
        image = "ghcr.io/hotio/whisparr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Whisparr/:/config"
          "${videosDir}:/videos"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "6969:6969" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Flaresolver Cloudflare Challenge Solver
      "flareSolverr" = {
        autoStart = true;
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8191:8191" ];
        environment = {
          LOG_LEVEL = "info";
        };
      };

      # Prowlarr Indexer Source Management
      "prowlarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/prowlarr";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "flareSolverr" ];
        volumes = [
          "${applicationConfigDir}/Prowlarr/:/config"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "9696:9696" ];
        environment = {
          TZ = lanAddress;
        };
      };

      # Jackett Indexer Source Management
      "jackett" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jackett:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "flareSolverr" ];
        environment = {
          TZ = timeZone;
          AUTO_UPDATE = "true";
        };
        volumes = [
          "${applicationConfigDir}/Jackett:/config"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "9117:9117" ];
      };

      "stash" = {
        autoStart = true;
        image = "ghcr.io/hotio/stash";
        volumes = [
          "${applicationConfigDir}/Stash/:/config"
          "${videosDir}:/videos"
          "${imagesDir}:/images"
        ];
        ports = [ "9999:9999" ];
        environment = {
          TZ = timeZone;
        };
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
      };

      # Server Homepage
      "homer" = {
        autoStart = true;
        image = "b4bz/homer:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Homer/:/www/assets"
        ];
        ports = [ "80:8080" ];
      };

      # RSS Feed Server, Scanner, Indexer & Organizer
      "freshRSS" = {
        autoStart = true;
        image = "freshrss/freshrss:edge";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/FreshRSS/data/:/var/www/FreshRSS/data"
          "${applicationConfigDir}/FreshRSS/extensions/:/var/www/FreshRSS/extensions"
        ];
        ports = [ "8808:80" ];
        environment = {
          TZ = timeZone;
          CRON_MIN = "2,32";
        };
      };

      # Book Server
      "kavita" = {
        autoStart = true;
        image = "jvmilazz0/kavita";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "5000:5000" ];
        volumes = [
          "${applicationConfigDir}/Kavita:/kavita/config"
          "${booksDir}:/books"
          "${magazinesDir}:/magazines"
        ];
      };

      # AudioBook Server
      "audiobookshelf" = {
        autoStart = true;
        image = "ghcr.io/advplyr/audiobookshelf:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "13378:80" ];
        volumes = [
          "${applicationConfigDir}/audiobookshelf:/config"
          "${audioBooksDir}:/audiobooks"
        ];
        environment = {
          TZ = timeZone;
        };
      };

      # Notification Server
      "ntfy" = {
        autoStart = true;
        image = "binwiederhier/ntfy";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        cmd = [ "serve" ];
        environment = {
          TZ = timeZone;
        };
        ports = [ "7777:80" ];
        volumes = [
          "${applicationConfigDir}/ntfy/cache:/var/cache/ntfy"
          "${applicationConfigDir}/ntfy/data/:/etc/ntfy"
        ];
      };

      # Server File Browser WebUI
      "filebrowser" = {
        autoStart = true;
        image = "filebrowser/filebrowser";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "6660:80" ];
        volumes = [
          "/mnt/data/:/srv"
          "${applicationConfigDir}/filebrowser/settings.json:/config/settings.json"
          "${applicationConfigDir}/filebrowser/filebrowser.db:/config/filebrowser.db"
        ];
        environment = {
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Youtube Media Downloader
      "metube" = {
        autoStart = true;
        image = "ghcr.io/alexta69/metube";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8081:8081" ];
        volumes = [
          "${videosDir}:/downloads"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          YTDL_OPTIONS = ''
            {
              "writesubtitles": true,
              "subtitleslangs": ["en","-live_chat"],
              "updatetime": false,
              "postprocessors": [
                { 
                  "key":"Exec",
                  "exec_cmd":"chmod 0664",
                  "when":"after_move"
                },
                {
                  "key": "FFmpegEmbedSubtitle",
                  "already_have_subtitle": false
                },
                {
                  "key": "FFmpegMetadata",
                  "add_chapters": true
                }
              ]
            } 
          '';
        };
      };

      # Aria2 Download Manager
      "aria2" = {
        autoStart = true;
        image = "abcminiuser/docker-aria2-with-webui:latest-ng";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "6800:6800" "6880:80" ];
        volumes = [
          "${downloadsDir}:/downloads"
          "${applicationConfigDir}/aria2:/conf"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Linkding Bookmarks Manager
      "linkding" = {
        autoStart = true;
        image = "sissbruecker/linkding:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/linkding:/etc/linkding/data"
        ];
        ports = [ "9090:9090" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Automation Bots
      "huginn" = {
        autoStart = true;
        image = "ghcr.io/huginn/huginn";
        ports = [ "3333:3000" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Service Health Monitoring
      "uptime-kuma" = {
        autoStart = true;
        image = "louislam/uptime-kuma:1";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/uptime-kuma/:/app/data"
        ];
        ports = [ "3001:3001" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      "photoprism" = {
        autoStart = true;
        image = "photoprism/photoprism";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" "--privileged" ];
        volumes = [
          "${applicationConfigDir}/photoprism/:/photoprism/storage"
          "${imagesDir}:/photoprism/originals"
        ];
        ports = [ "2342:2342" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          PHOTOPRISM_UPLOAD_NSFW = "true";
          PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism.password;
        };
      };

      "portrainer" = {
        autoStart = true;
        image = "portainer/portainer-ce:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [
          "8024:8000"
          "9443:9443"
          "9080:9000"
        ];
        volumes = [
          "${podmanSocket}:/var/run/docker.sock"
          "${applicationConfigDir}/portrainer:/data"
        ];
      };

      "bazarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/bazarr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "6767:6767" ];
        volumes = [
          "${applicationConfigDir}/Bazarr/config:/config"
          "${tvDir}:/tv"
          "${moviesDir}:/movies"
          "${encTvDir}:/enctv"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = [ "4533:4533" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/navidrome"
          "${musicDir}:/music:ro"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          ND_SCANSCHEDULE = "1h";
          ND_LOGLEVEL = "info";
          ND_SESSIONTIMEOUT = "24h";
          ND_BASEURL = "";
        };
      };

      "znc" = {
        autoStart = true;
        image = "lscr.io/linuxserver/znc:latest";
        ports = [ "6501:6501" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/znc/:/config"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      "thelounge" = {
        autoStart = true;
        image = "ghcr.io/thelounge/thelounge:latest";
        ports = [ "9000:9000" ];
        volumes = [ "${applicationConfigDir}/thelounge:/var/opt/thelounge" ];
      };

      "firefly-db" = {
        autoStart = true;
        image = "mariadb:lts";
        ports = [ "3306:3306" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/firefly/db:/var/lib/mysql"
        ];
        environment = {
          MYSQL_RANDOM_ROOT_PASSWORD = "yes";
          MYSQL_USER = "firefly";
          MYSQL_PASSWORD = secrets.firefly.db.password;
          MYSQL_DATABASE = "firefly";
        };
      };

      "firefly-app" = {
        autoStart = true;
        image = "fireflyiii/core:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "firefly-db" ];
        ports = [ "6003:8080" ];
        volumes = [
          "${applicationConfigDir}/firefly/uploads/:/var/www/html/storage/upload"
        ];
        environment = {
          APP_ENV = "production";
          SITE_OWNER = secrets.firefly.app.site_owner;
          APP_KEY = secrets.firefly.app.secret;
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          DB_CONNECTION = "mysql";
          DB_HOST = "nullptrderef1";
          DB_PORT = "3306";
          DB_DATABASE = "firefly";
          DB_USERNAME = "firefly";
          DB_PASSWORD = secrets.firefly.db.password;
          MYSQL_USE_SSL = "false";
          MYSQL_SSL_VERIFY_SERVER_CERT = "false";
          APP_URL = "http://nullptrderef1";
        };
      };
    };
}
