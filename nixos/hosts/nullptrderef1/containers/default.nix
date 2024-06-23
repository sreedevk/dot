{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./jellyfin.nix
    ./jellyseer.nix
    ./plex.nix
    ./qbittorrent.nix
    ./autobrr.nix
    ./vaultwarden.nix
    ./homebox.nix
    ./servarr.nix
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    autoPrune.enable = true;
  };

  virtualisation.oci-containers.containers = {
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
      image = "hurlenko/aria2-ariang";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "6880:8080" "6800:6800" ];
      volumes = [
        "${opts.paths.downloads}/Aria2:/aria2/data"
        "${opts.paths.application_data}/aria2:/aria2/conf"
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
