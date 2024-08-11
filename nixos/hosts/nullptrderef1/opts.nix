{
  hostname = "nullptrderef1";

  lanAddress = "192.168.1.179";
  adminUID = "1000";
  adminGID = "100";

  nameservers = [ "9.9.9.9" "149.112.112.112" "194.242.2.5" ];

  paths = {
    application_data = "/mnt/dpool1/appdata/files";
    application_data_archive = "/mnt/dpool0/appdata/files";
    application_databases = "/mnt/dpool1/appdata/databases";
    application_databases_archive = "/mnt/dpool0/appdata/databases";
    audiobooks = "/mnt/dpool0/media/audiobooks";
    books = "/mnt/dpool0/media/books";
    documents = "/mnt/dpool0/personal/documents";
    downloads = "/mnt/dpool0/downloads";
    images = "/mnt/dpool0/media/photos";
    llama-cpp-models = "/mnt/dpool0/resources/llms/llama-cpp-models";
    magazines = "/mnt/dpool0/media/magazines";
    movies = "/mnt/dpool0/media/movies";
    music = "/mnt/dpool0/media/music";
    other = "/mnt/dpool0/other";
    podcasts = "/mnt/dpool0/media/podcasts";
    podmanSocket = "/var/run/podman/podman.sock";
    qbt_images = "/mnt/dpool0/media/photos/other";
    television = "/mnt/dpool0/media/shows";
    torrent_watch = "/mnt/dpool0/downloads/torrents";
    videos = "/mnt/dpool0/media/videos";
  };

  ports = {
    actual-app = "5006";
    adguard_dns = "53";
    adguard_web = "8000";
    archivebox = "8089";
    aria_rpc = "6800";
    aria_web = "6880";
    audiobookshelf = "13378";
    baikal = "8945";
    bazarr = "6767";
    cloudbeaver = "8079";
    cockpit = "8008";
    container-registry-server = "5500";
    container-registry-web = "5600";
    docuseal = "6008";
    filebrowser = "6660";
    firefly_app = "6003";
    firefly_db = "3306";
    flaresolverr = "8191";
    freshrss-app = "8808";
    freshrss-db = "3311";
    ftp = "21";
    gitea_db = "3309";
    gitea_http = "3000";
    gitea_ssh = "222";
    gotify = "8773";
    grafana = "2442";
    homebox = "3100";
    homer = "82";
    https = "443";
    icecast = "8099";
    jackett = "9117";
    jellyfin = "8096";
    jellyseer = "5055";
    k3s-control-plane = "6443";
    k3s-inter-node-net = "8472";
    k3s-etcd-clients = "2379";
    k3s-etcd-peers = "2380";
    kavita = "5000";
    lidarr = "8686";
    linkding-app = "9090";
    linkding-db = "5432";
    llama-cpp-server = "8100";
    memos = "5230";
    metube = "8081";
    navidrome = "4533";
    netdata = "19999";
    ntfy = "7777";
    olivetin = "1337";
    ollama-api = "11434";
    ollama-web = "3134";
    openbooks = "8004";
    paperless-app = "8991";
    paperless-db = "3316";
    paperless-redis = "6340";
    photoprism_app = "2342";
    photoprism_db = "3307";
    plex = "32400";
    podgrab = "8567";
    portrainer_misc = "8024";
    portrainer_web = "9080";
    portrainer_web_secure = "9443";
    prometheus_app = "9001";
    prometheus_node = "9002";
    prometheus_zfs = "9134";
    prowlarr = "9696";
    qbittorrent-p2p = "6881";
    qbittorrent-web = "8001";
    radarr = "7878";
    readarr = "8787";
    rss-bridge = "8768";
    searxng = "9199";
    sonarr = "8989";
    ssh = "22";
    taskchampion = "8080";
    tubearchivist = "8780";
    tubearchivist-es = "9200";
    tubearchivist-redis = "6379";
    uptime-kuma = "3001";
    vaultwarden = "9801";
    whisper = "9000";
  };

  mountpoints = [
    # DPOOL0
    { device = "dpool0/media"; path = "/mnt/dpool0/media"; }
    { device = "dpool0/media/videos"; path = "/mnt/dpool0/media/videos"; }
    { device = "dpool0/media/movies"; path = "/mnt/dpool0/media/movies"; }
    { device = "dpool0/media/music"; path = "/mnt/dpool0/media/music"; }
    { device = "dpool0/media/photos"; path = "/mnt/dpool0/media/photos"; }
    { device = "dpool0/media/shows"; path = "/mnt/dpool0/media/shows"; }
    { device = "dpool0/other"; path = "/mnt/dpool0/other"; }
    { device = "dpool0/other"; path = "/mnt/dpool0/other"; }
    { device = "dpool0/secrets"; path = "/mnt/dpool0/secrets"; }
    { device = "dpool0/notes"; path = "/mnt/dpool0/notes"; }
    { device = "dpool0/appdata"; path = "/mnt/dpool0/appdata"; }
    { device = "dpool0/backups"; path = "/mnt/dpool0/backups"; }
    { device = "dpool0/resources"; path = "/mnt/dpool0/resources"; }
    { device = "dpool0/resources/llms"; path = "/mnt/dpool0/resources/llms"; }
    { device = "dpool0/resources/databases"; path = "/mnt/dpool0/resources/databases"; }
    { device = "dpool0/resources/wordlists"; path = "/mnt/dpool0/resources/wordlists"; }
    { device = "dpool0/resources/other"; path = "/mnt/dpool0/resources/other"; }
    { device = "dpool0/personal"; path = "/mnt/dpool0/personal"; }
    { device = "dpool0/personal/documents"; path = "/mnt/dpool0/personal/documents"; }
    { device = "dpool0/personal/finances"; path = "/mnt/dpool0/personal/finances"; }
    { device = "dpool0/personal/projects"; path = "/mnt/dpool0/personal/projects"; }
    { device = "dpool0/personal/archives"; path = "/mnt/dpool0/personal/archives"; }
    { device = "dpool0/personal/other"; path = "/mnt/dpool0/personal/other"; }
    { device = "dpool0/media/magazines"; path = "/mnt/dpool0/media/magazines"; }
    { device = "dpool0/media/audiobooks"; path = "/mnt/dpool0/media/audiobooks"; }
    { device = "dpool0/media/books"; path = "/mnt/dpool0/media/books"; }
    { device = "dpool0/downloads"; path = "/mnt/dpool0/downloads"; }
    { device = "dpool0/downloads/torrents"; path = "/mnt/dpool0/downloads/torrents"; }
    { device = "dpool0/media/audio"; path = "/mnt/dpool0/media/audio"; }
    { device = "dpool0/appdata/databases"; path = "/mnt/dpool0/appdata/databases"; }
    { device = "dpool0/appdata/files"; path = "/mnt/dpool0/appdata/files"; }
    { device = "dpool0/media/podcasts"; path = "/mnt/dpool0/media/podcasts"; }

    # DPOOL1
    { device = "dpool1/appdata"; path = "/mnt/dpool1/appdata"; }
    { device = "dpool1/appdata/files"; path = "/mnt/dpool1/appdata/files"; }
    { device = "dpool1/appdata/databases"; path = "/mnt/dpool1/appdata/databases"; }
  ];

}
