{ config, lib, pkgs, secrets, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };

  virtualisation.oci-containers.containers =
    let
      opts = {
        applicationUserName = "nullptrderef1";
        lanAddress = "192.168.1.179";
        timeZone = "America/New_York";
        adminUID = "1000";
        adminGID = "100";
        paths = {
          downloadsDir = "/mnt/data/downloads/";
          torrentsWatchDir = "/mnt/data/torrents/";
          encAppData = "/mnt/enc_data_drive/AppData";
          applicationConfigDir = "/mnt/data/applications";
          moviesDir = "/mnt/data/media/movies/";
          tvDir = "/mnt/data/media/shows/";
          audioBooksDir = "/mnt/data/media/audiobooks/";
          musicDir = "/mnt/data/media/music/";
          videosDir = "/mnt/data/media/videos/";
          imagesDir = "/mnt/data/media/images/";
          encImagesDir = "/mnt/enc_data_drive/media/images/";
          booksDir = "/mnt/data/media/books/";
          magazinesDir = "/mnt/data/media/magazines/";
          encTvDir = "/mnt/enc_data_drive/media/shows/";
          encVideosDir = "/mnt/enc_data_drive/media/videos/";
          podmanSocket = "/var/run/podman/podman.sock";
        };
      };
    in
    {
      # Jellyfin Media Player
      "jellyfin" = {
        autoStart = true;
        image = "jellyfin/jellyfin";
        volumes = [
          "${opts.paths.applicationConfigDir}/jellyfin/config:/config"
          "${opts.paths.applicationConfigDir}/jellyfin/cache/:/cache"
          "${opts.paths.applicationConfigDir}/jellyfin/log/:/log"
          "${opts.paths.moviesDir}:/movies"
          "${opts.paths.tvDir}:/tv"
          "${opts.paths.encTvDir}:/enctv"
          "${opts.paths.audioBooksDir}:/audiobooks"
          "${opts.paths.musicDir}:/music"
        ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8096:8096" ];
        environment = { JELLYFIN_LOG_DIR = "/log"; };
      };

      # Jellyseer Media Discovery
      "jellyseer" = {
        autoStart = true;
        image = "fallenbagel/jellyseerr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.applicationConfigDir}/jellyseer/:/app/config" ];
        ports = [ "5055:5055" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Plex Media Server
      "plex" = {
        autoStart = true;
        image = "plexinc/pms-docker";
        extraOptions = [ "--network=host" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/plex/database/:/config"
          "${opts.paths.applicationConfigDir}/plex/transcode/:/transcode"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
          TZ = opts.timeZone;
          USER_UID = opts.adminUID;
          USER_GID = opts.adminGID;
        };
        volumes = [
          "${opts.paths.applicationConfigDir}/qbittorrent/config/:/config"
          "${opts.paths.applicationConfigDir}/vuetorrent:/vuetorrent"
          "${opts.paths.downloadsDir}:/downloads"
          "${opts.paths.torrentsWatchDir}:/torrents"
          "${opts.paths.imagesDir}:/images"
          "${opts.paths.videosDir}:/videos"
          "${opts.paths.booksDir}:/books"
          "${opts.paths.magazinesDir}:/magazines"
        ];
        extraOptions = [ "--network=host" "--no-healthcheck" ];
      };

      "autobrr" = {
        autoStart = true;
        image = "ghcr.io/autobrr/autobrr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "qbittorrent-nox" ];
        ports = [ "7474:7474" ];
        volumes = [ "${opts.paths.applicationConfigDir}/autobrr/:/config" ];
        environment = { TZ = opts.timeZone; };
      };

      "vaultwarden" = {
        autoStart = true;
        image = "vaultwarden/server:latest ";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "9801:80" ];
        volumes = [ "/mnt/enc_data_drive/secrets/vw-data:/data/" ];
      };

      "homebox" = {
        autoStart = true;
        image = "ghcr.io/hay-kot/homebox:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "3100:7745" ];
        volumes = [ "${opts.paths.applicationConfigDir}/Homebox:/data" ];
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
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "qbittorrent-nox" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Radarr/:/config"
          "${opts.paths.moviesDir}:/movies"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "7878:7878" ];
        environment = { TZ = opts.timeZone; };
      };

      # Sonarr TV Indexer
      "sonarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/sonarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Sonarr/:/config"
          "${opts.paths.tvDir}:/tv"
          "${opts.paths.encTvDir}:/enctv"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "8989:8989" ];
        environment = { TZ = opts.timeZone; };
      };

      # Lidarr Music Indexer
      "lidarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/lidarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Lidarr/:/config"
          "${opts.paths.musicDir}:/music"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "8686:8686" ];
        environment = { TZ = opts.timeZone; };
      };

      # Readarr Books Indexer
      "readarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/readarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Readarr/:/config"
          "${opts.paths.booksDir}:/books"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "8787:8787" ];
        environment = { TZ = opts.timeZone; };
      };

      "openbooks" = {
        autoStart = true;
        image = "evanbuss/openbooks";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.booksDir}:/books" ];
        ports = [ "8004:80" ];
        cmd = [ "--persist" "--name='${opts.applicationUserName}'" ];
        environment = { TZ = opts.timeZone; };
      };

      # Flaresolver Cloudflare Challenge Solver
      "flareSolverr" = {
        autoStart = true;
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8191:8191" ];
        environment = { LOG_LEVEL = "info"; };
      };

      # Prowlarr Indexer Source Management
      "prowlarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/prowlarr";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "flareSolverr" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Prowlarr/:/config"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "9696:9696" ];
        environment = { TZ = opts.lanAddress; };
      };

      # Jackett Indexer Source Management
      "jackett" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jackett:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "flareSolverr" ];
        environment = {
          TZ = opts.timeZone;
          AUTO_UPDATE = "true";
        };
        volumes = [
          "${opts.paths.applicationConfigDir}/Jackett:/config"
          "${opts.paths.downloadsDir}:/downloads"
        ];
        ports = [ "9117:9117" ];
      };

      # Server Homepage
      "homer" = {
        autoStart = true;
        image = "b4bz/homer:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.applicationConfigDir}/Homer/:/www/assets" ];
        ports = [ "80:8080" ];
      };

      # RSS Feed Server, Scanner, Indexer & Organizer
      "freshRSS" = {
        autoStart = true;
        image = "freshrss/freshrss:edge";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/FreshRSS/data/:/var/www/FreshRSS/data"
          "${opts.paths.applicationConfigDir}/FreshRSS/extensions/:/var/www/FreshRSS/extensions"
        ];
        ports = [ "8808:80" ];
        environment = {
          TZ = opts.timeZone;
          CRON_MIN = "2,32";
        };
      };

      # Book Server
      "kavita" = {
        autoStart = true;
        image = "jvmilazz0/kavita";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "5000:5000" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Kavita:/kavita/config"
          "${opts.paths.booksDir}:/books"
          "${opts.paths.magazinesDir}:/magazines"
        ];
      };

      # AudioBook Server
      "audiobookshelf" = {
        autoStart = true;
        image = "ghcr.io/advplyr/audiobookshelf:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "13378:80" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/audiobookshelf:/config"
          "${opts.paths.audioBooksDir}:/audiobooks"
        ];
        environment = { TZ = opts.timeZone; };
      };

      # Notification Server
      "ntfy" = {
        autoStart = true;
        image = "binwiederhier/ntfy";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        cmd = [ "serve" ];
        environment = { TZ = opts.timeZone; };
        ports = [ "7777:80" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/ntfy/cache:/var/cache/ntfy"
          "${opts.paths.applicationConfigDir}/ntfy/data/:/etc/ntfy"
        ];
      };

      # Server File Browser WebUI
      "filebrowser" = {
        autoStart = true;
        image = "filebrowser/filebrowser";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "6660:80" ];
        volumes = [
          "/mnt/data/:/srv"
          "${opts.paths.applicationConfigDir}/filebrowser/settings.json:/config/settings.json"
          "${opts.paths.applicationConfigDir}/filebrowser/filebrowser.db:/config/filebrowser.db"
          "${opts.paths.applicationConfigDir}/filebrowser/database.db:/config/database.db"
        ];
        environment = {
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Youtube Media Downloader
      "metube" = {
        autoStart = true;
        image = "ghcr.io/alexta69/metube";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8081:8081" ];
        volumes = [ "${opts.paths.downloadsDir}/Metube:/downloads" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "6800:6800" "6880:80" ];
        volumes = [
          "${opts.paths.downloadsDir}:/downloads"
          "${opts.paths.applicationConfigDir}/aria2:/conf"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Linkding Bookmarks Manager
      "linkding" = {
        autoStart = true;
        image = "sissbruecker/linkding:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes =
          [ "${opts.paths.applicationConfigDir}/linkding:/etc/linkding/data" ];
        ports = [ "9090:9090" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Automation Bots
      "huginn" = {
        autoStart = true;
        image = "ghcr.io/huginn/huginn";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "3333:3000" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Service Health Monitoring
      "uptime-kuma" = {
        autoStart = true;
        image = "louislam/uptime-kuma:1";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.applicationConfigDir}/uptime-kuma/:/app/data" ];
        ports = [ "3001:3001" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "photoprism" = {
        autoStart = true;
        image = "photoprism/photoprism";
        extraOptions = [
          "--add-host=nullptrderef1:${opts.lanAddress}"
          "--privileged"
          "--no-healthcheck"
        ];
        volumes = [
          "${opts.paths.encAppData}/photoprism/:/photoprism/storage"
          "${opts.paths.imagesDir}:/photoprism/originals/generic"
          "${opts.paths.encImagesDir}:/photoprism/originals/personal"
        ];
        ports = [ "2342:2342" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
          PHOTOPRISM_UPLOAD_NSFW = "true";
          PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism.password;
        };
      };

      "portrainer" = {
        autoStart = true;
        image = "portainer/portainer-ce:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8024:8000" "9443:9443" "9080:9000" ];
        volumes = [
          "${opts.paths.podmanSocket}:/var/run/docker.sock"
          "${opts.paths.applicationConfigDir}/portrainer:/data"
        ];
      };

      "bazarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/bazarr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "6767:6767" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/Bazarr/config:/config"
          "${opts.paths.tvDir}:/tv"
          "${opts.paths.moviesDir}:/movies"
          "${opts.paths.encTvDir}:/enctv"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = [ "4533:4533" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/navidrome"
          "${opts.paths.musicDir}:/music:ro"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.applicationConfigDir}/znc/:/config" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "thelounge" = {
        autoStart = true;
        image = "ghcr.io/thelounge/thelounge:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "9000:9000" ];
        volumes =
          [ "${opts.paths.applicationConfigDir}/thelounge:/var/opt/thelounge" ];
      };

      "firefly-db" = {
        autoStart = true;
        image = "mariadb:lts";
        ports = [ "3306:3306" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes =
          [ "${opts.paths.applicationConfigDir}/firefly/db:/var/lib/mysql" ];
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
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "firefly-db" ];
        ports = [ "6003:8080" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/firefly/uploads/:/var/www/html/storage/upload"
        ];
        environment = {
          APP_ENV = "production";
          SITE_OWNER = secrets.firefly.app.site_owner;
          APP_KEY = secrets.firefly.app.secret;
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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

      "docuseal" = {
        autoStart = true;
        image = "docuseal/docuseal";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "6008:3000" ];
        volumes = [ "${opts.paths.applicationConfigDir}/docuseal:/data" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "livebook" = {
        autoStart = true;
        image = "ghcr.io/livebook-dev/livebook";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8090:8080" "8091:8081" ];
        volumes = [ "${opts.paths.applicationConfigDir}/livebook:/data" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
          LIVEBOOK_PASSWORD = secrets.livebook.password;
        };
      };

      "archivebox" = {
        autoStart = true;
        image = "archivebox/archivebox";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8089:8000" ];
        volumes = [ "${opts.paths.applicationConfigDir}/archivebox:/data" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "cloudbeaver" = {
        autoStart = true;
        image = "dbeaver/cloudbeaver:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8079:8978" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/cloudbeaver:/opt/cloudbeaver/workspace"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "farfalle" = {
        autoStart = true;
        image = "ghcr.io/rashadphz/farfalle:main";
        extraOptions = [
          "--add-host=nullptrderef1:${opts.lanAddress}"
          "--add-host=host.docker.internal:host-gateway"
          "--no-healthcheck"
        ];
        ports = [ "8199:8000" "9199:8080" "3199:3000" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
          SEARCH_PROVIDER = "searxng";
          TAVILY_API_KEY = secrets.farfalle.tavily_api_key;
          SEARXNG_BASE_URL = "http://nullptrderef1:9199/";
        };
      };

      "ollama" = {
        autoStart = true;
        image = "ollama/ollama";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.applicationConfigDir}/Ollama:/root/.ollama" ];
        ports = [ "11434:11434" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "ollama-web" = {
        autoStart = true;
        image = "ghcr.io/open-webui/open-webui:main";
        extraOptions = [
          "--add-host=nullptrderef1:${opts.lanAddress}"
          "--add-host=host.docker.internal:host-gateway"
          "--no-healthcheck"
        ];
        volumes =
          [ "${opts.paths.applicationConfigDir}/OllamaWeb:/app/backend/data" ];
        ports = [ "3134:8080" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "rss-bridge" = {
        autoStart = true;
        image = "rssbridge/rss-bridge:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8768:80" ];
        volumes = [ "${opts.paths.applicationConfigDir}/rss-bridge:/config" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "baikal" = {
        autoStart = true;
        image = "ckulka/baikal:nginx";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8945:80" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/baikal/config:/var/www/baikal/config"
          "${opts.paths.applicationConfigDir}/baikal/data:/var/www/baikal/Specific"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "olivetin" = {
        autoStart = true;
        image = "jamesread/olivetin";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/olivetin:/config"
          "${opts.paths.podmanSocket}:/var/run/docker.sock"
        ];
        ports = [ "1337:1337" ];
        user = "root";
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "memos" = {
        autoStart = true;
        ports = [ "5230:5230" ];
        image = "neosmemo/memos:stable";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.applicationConfigDir}/memos:/var/opt/memos"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };
    };
}
