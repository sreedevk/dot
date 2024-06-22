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
          application_data = "/mnt/dpool0/appdata";
          downloads = "/mnt/dpool0/downloads";
          magazines = "/mnt/dpool0/media/magazines";
          qbt_images = "/mnt/dpool0/media/photos/other";
          images = "/mnt/dpool0/media/photos";
          torrent_watch = "/mnt/dpool0/downloads/torrents";
          movies = "/mnt/dpool0/media/movies";
          audiobooks = "/mnt/dpool0/media/audiobooks";
          books = "/mnt/dpool0/media/books";
          music = "/mnt/dpool0/media/music";
          videos = "/mnt/dpool0/media/videos";
          television = "/mnt/dpool0/media/shows";

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
          "${opts.paths.application_data}/jellyfin/config:/config"
          "${opts.paths.application_data}/jellyfin/cache/:/cache"
          "${opts.paths.application_data}/jellyfin/log/:/log"
          "${opts.paths.movies}:/movies"
          "${opts.paths.television}:/tv"
          "${opts.paths.audiobooks}:/audiobooks"
          "${opts.paths.music}:/music"
        ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8096:8096" ];
        environment = {
          JELLYFIN_LOG_DIR = "/log";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Jellyseer Media Discovery
      "jellyseer" = {
        autoStart = true;
        image = "fallenbagel/jellyseerr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.application_data}/jellyseer/:/app/config" ];
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
          "${opts.paths.application_data}/plex/database/:/config"
          "${opts.paths.application_data}/plex/transcode/:/transcode"
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
          "${opts.paths.application_data}/qbittorrent/config/:/config"
          "${opts.paths.application_data}/vuetorrent:/vuetorrent"
          "${opts.paths.downloads}:/downloads"
          "${opts.paths.torrent_watch}:/torrents"
          "${opts.paths.qbt_images}:/images"
          "${opts.paths.videos}:/videos"
          "${opts.paths.books}:/books"
          "${opts.paths.magazines}:/magazines"
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
        volumes = [ "${opts.paths.application_data}/autobrr/:/config" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "vaultwarden" = {
        autoStart = true;
        image = "vaultwarden/server:latest ";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "9801:80" ];
        volumes = [ "/mnt/enc_data_drive/secrets/vw-data:/data/" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "homebox" = {
        autoStart = true;
        image = "ghcr.io/hay-kot/homebox:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "3100:7745" ];
        volumes = [ "${opts.paths.application_data}/HomeBox:/data" ];
        environment = {
          HBOX_LOG_LEVEL = "info";
          HBOX_LOG_FORMAT = "text";
          HBOX_WEB_MAX_UPLOAD_SIZE = "10";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
          "${opts.paths.application_data}/Radarr/:/config"
          "${opts.paths.movies}:/movies"
          "${opts.paths.downloads}:/downloads"
        ];
        ports = [ "7878:7878" ];
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
        ports = [ "8989:8989" ];
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
        ports = [ "8787:8787" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "openbooks" = {
        autoStart = true;
        image = "evanbuss/openbooks";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.books}:/books" ];
        ports = [ "8004:80" ];
        cmd = [ "--persist" "--name='${opts.applicationUserName}'" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Flaresolver Cloudflare Challenge Solver
      "flareSolverr" = {
        autoStart = true;
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "8191:8191" ];
        environment = {
          LOG_LEVEL = "info";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Prowlarr Indexer Source Management
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

      # Jackett Indexer Source Management
      "jackett" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jackett:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        dependsOn = [ "flareSolverr" ];
        environment = {
          AUTO_UPDATE = "true";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
        volumes = [
          "${opts.paths.application_data}/Jackett:/config"
          "${opts.paths.downloads}:/downloads"
        ];
        ports = [ "9117:9117" ];
      };

      # Server Homepage
      "homer" = {
        autoStart = true;
        image = "b4bz/homer:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [ "${opts.paths.application_data}/Homer/:/www/assets" ];
        ports = [ "80:8080" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # RSS Feed Server, Scanner, Indexer & Organizer
      "freshRSS" = {
        autoStart = true;
        image = "freshrss/freshrss:edge";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.application_data}/FreshRSS/data/:/var/www/FreshRSS/data"
          "${opts.paths.application_data}/FreshRSS/extensions/:/var/www/FreshRSS/extensions"
        ];
        ports = [ "8808:80" ];
        environment = {
          CRON_MIN = "2,32";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
          "${opts.paths.application_data}/Kavita:/kavita/config"
          "${opts.paths.books}:/books"
          "${opts.paths.magazines}:/magazines"
        ];

        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # AudioBook Server
      "audiobookshelf" = {
        autoStart = true;
        image = "ghcr.io/advplyr/audiobookshelf:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "13378:80" ];
        volumes = [
          "${opts.paths.application_data}/AudioBookShelf:/config"
          "${opts.paths.audiobooks}:/audiobooks"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      # Notification Server
      "ntfy" = {
        autoStart = true;
        image = "binwiederhier/ntfy";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        cmd = [ "serve" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
        ports = [ "7777:80" ];
        volumes = [
          "${opts.paths.application_data}/ntfy/cache:/var/cache/ntfy"
          "${opts.paths.application_data}/ntfy/data/:/etc/ntfy"
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
          "/mnt/dpool0/:/srv"
          "${opts.paths.application_data}/filebrowser/settings.json:/config/settings.json"
          "${opts.paths.application_data}/filebrowser/filebrowser.db:/config/filebrowser.db"
          "${opts.paths.application_data}/filebrowser/database.db:/config/database.db"
        ];
        environment = {
          TZ = opts.timeZone;
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
        volumes = [ "${opts.paths.downloads}/Metube:/downloads" ];
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
        image = "wahyd4/aria2-ui:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        ports = [ "6880:80" ];
        volumes = [
          "${opts.paths.downloads}/Aria2:/data"
          "${opts.paths.application_data}/aria2:/app/conf"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
          ENABLE_AUTH = "true";
          ARIA2_USER = secrets.aria2.username;
          ARIA2_PWD = secrets.aria2.password;
          ARIA2_SSL = "false";
          DOMAIN = "http://nullptrderef1";
        };
      };

      # Linkding Bookmarks Manager
      "linkding" = {
        autoStart = true;
        image = "sissbruecker/linkding:latest";
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes =
          [ "${opts.paths.application_data}/Linkding:/etc/linkding/data" ];
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
        volumes = [ "${opts.paths.application_data}/uptime-kuma/:/app/data" ];
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
          "${opts.paths.application_data}/Photoprism/:/photoprism/storage"
          "${opts.paths.images}:/photoprism/originals"
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
          "${opts.paths.application_data}/Portrainer:/data"
        ];
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
        ports = [ "6767:6767" ];
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

      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = [ "4533:4533" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes = [
          "${opts.paths.application_data}/navidrome"
          "${opts.paths.music}:/music:ro"
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
        volumes = [ "${opts.paths.application_data}/znc/:/config" ];
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
          [ "${opts.paths.application_data}/thelounge:/var/opt/thelounge" ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };

      "firefly-db" = {
        autoStart = true;
        image = "mariadb:lts";
        ports = [ "3306:3306" ];
        extraOptions =
          [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
        volumes =
          [ "${opts.paths.application_data}/FireFly/db:/var/lib/mysql" ];
        environment = {
          MYSQL_RANDOM_ROOT_PASSWORD = "yes";
          MYSQL_USER = "firefly";
          MYSQL_PASSWORD = secrets.firefly.db.password;
          MYSQL_DATABASE = "firefly";
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
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
          "${opts.paths.application_data}/FireFly/uploads/:/var/www/html/storage/upload"
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
        volumes = [ "${opts.paths.application_data}/Docuseal:/data" ];
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
        volumes = [ "${opts.paths.application_data}/livebook:/data" ];
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
        volumes = [ "${opts.paths.application_data}/ArchiveBox:/data" ];
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
          "${opts.paths.application_data}/cloudbeaver:/opt/cloudbeaver/workspace"
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
        volumes = [ "${opts.paths.application_data}/Ollama:/root/.ollama" ];
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
        volumes = [
          "${opts.paths.application_data}/OllamaWeb:/app/backend/data"
        ];
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
        volumes = [ "${opts.paths.application_data}/rss-bridge:/config" ];
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
          "${opts.paths.application_data}/Baikal:/var/www/baikal/config"
          "${opts.paths.application_data}/Baikal:/var/www/baikal/Specific"
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
          "${opts.paths.application_data}/olivetin:/config"
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
          "${opts.paths.application_data}/Memos:/var/opt/memos"
        ];
        environment = {
          TZ = opts.timeZone;
          PUID = opts.adminUID;
          PGID = opts.adminGID;
        };
      };
    };
}
