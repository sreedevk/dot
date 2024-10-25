rec {
  hostname = "nullptrderef1";
  lanAddress = "192.168.1.179";
  adminUID = "1000";
  adminGID = "100";
  nameservers = [
    "9.9.9.9"
    "149.112.112.112"
    "194.242.2.2"
    "194.242.2.3"
    "194.242.2.4"
  ];

  paths = {
    app_datafiles = "/opt/appdata/files";
    audiobooks = "/mnt/dpool0/media/audiobooks";
    backups = "/mnt/dpool0/backups";
    books = "/mnt/dpool0/media/books";
    documents = "/mnt/dpool0/personal/documents";
    downloads = "/opt/downloads";
    images = "/mnt/dpool0/media/photos";
    magazines = "/mnt/dpool0/media/magazines";
    media = "/mnt/dpool0/media";
    movies = "/mnt/dpool0/media/movies";
    music = "/mnt/dpool0/media/music";
    other = "/mnt/dpool0/other";
    podcasts = "/mnt/dpool0/media/podcasts";
    podmanSocket = "/var/run/podman/podman.sock";
    qbt_images = "/mnt/dpool0/media/photos/other";
    television = "/mnt/dpool0/media/shows";
    videos = "/mnt/dpool0/media/videos";
    zim = "/mnt/dpool0/resources/zim";
    roms = "/mnt/dpool0/resources/roms";
  };

  ports = {
    actual-app = "5006";
    adguard_dns = "53";
    adguard_web = "8000";
    archivebox = "8089";
    aria_rpc = "6800";
    aria_web = "6880";
    audiobookshelf = "13378";
    authentik-app-http = "9989";
    authentik-app-https = "9990";
    authentik-db = "5434";
    authentik-redis = "6388";
    baikal = "8945";
    bazarr = "6767";
    beets = "8337";
    cloudbeaver = "8079";
    cockpit = "8008";
    container-registry-server = "5500";
    container-registry-web = "5600";
    dockge = "5001";
    docuseal = "6008";
    filebrowser = "8980";
    firefly_app = "10800";
    firefly_db = "3338";
    flaresolverr = "8191";
    ftp = "21";
    gitea_db = "3309";
    gitea_http = "3000";
    gitea_ssh = "222";
    gotify = "8773";
    grafana = "2442";
    homer = "82";
    http = "80";
    https = "443";
    influxdb = "8086";
    jackett = "9117";
    jellyfin = "8096";
    jellyseer = "5055";
    jellystat-app = "8906";
    jellystat-db = "5433";
    k3s-control-plane = "6443";
    k3s-etcd-clients = "2379";
    k3s-etcd-peers = "2380";
    k3s-inter-node-net = "8472";
    kavita = "5000";
    kiwix = "8888";
    lidarr = "8686";
    linkding-app = "9090";
    linkding-db = "5432";
    livebook_api = "8091";
    livebook_http = "8090";
    loki = "3100";
    memos = "5230";
    metube = "8081";
    miniflux-app = "10000";
    miniflux-db = "3311";
    minio-api = "30000";
    minio-console = "9899";
    n8n-app = "23000";
    n8n-db = "5435";
    navidrome = "4533";
    nginx-proxy-manager = "81";
    olivetin = "1337";
    ollama-api = "11434";
    ollama-web = "3134";
    paperless-app = "8991";
    paperless-db = "3316";
    paperless-redis = "6340";
    photoprism_app = "2342";
    photoprism_db = "3307";
    podgrab = "8567";
    portainer_misc = "8024";
    portainer_web = "9080";
    portainer_web_secure = "9443";
    prometheus_app = "9001";
    prometheus_node = "9002";
    prometheus_smartctl = "9003";
    prometheus_zfs = "9004";
    promtail = "3800";
    prowlarr = "9696";
    qbittorrent-p2p = "6881";
    qbittorrent-web = "8001";
    radarr = "7878";
    readarr = "8787";
    romm-app = "8900";
    romm-db = "5466";
    rss-bridge = "8768";
    sabnzbd = "8099";
    searxng-www = "8798";
    sonarr = "8989";
    ssh = "22";
    stirling-pdf = "9987";
    tailscale_direct = "39158";
    tailscale_p2p = "41641";
    taskchampion = "8080";
    tautulli = "8181";
    tdarr-node = "8268";
    tdarr-server = "8266";
    tdarr-web = "8265";
    tubearchivist = "8780";
    tubearchivist-es = "9200";
    tubearchivist-redis = "6379";
    unbound_dns = "5053";
    uptime-kuma = "3001";
    vaultwarden = "9801";
    watch-your-lan = "8840";
  };

  mountpoints = [
    # DPOOL0
    { device = "dpool0/backups"; path = "/mnt/dpool0/backups"; }
    { device = "dpool0/media"; path = "/mnt/dpool0/media"; }
    { device = "dpool0/media/audio"; path = "/mnt/dpool0/media/audio"; }
    { device = "dpool0/media/audiobooks"; path = "/mnt/dpool0/media/audiobooks"; }
    { device = "dpool0/media/books"; path = "/mnt/dpool0/media/books"; }
    { device = "dpool0/media/magazines"; path = "/mnt/dpool0/media/magazines"; }
    { device = "dpool0/media/movies"; path = "/mnt/dpool0/media/movies"; }
    { device = "dpool0/media/music"; path = "/mnt/dpool0/media/music"; }
    { device = "dpool0/media/photos"; path = "/mnt/dpool0/media/photos"; }
    { device = "dpool0/media/podcasts"; path = "/mnt/dpool0/media/podcasts"; }
    { device = "dpool0/media/shows"; path = "/mnt/dpool0/media/shows"; }
    { device = "dpool0/media/videos"; path = "/mnt/dpool0/media/videos"; }
    { device = "dpool0/notes"; path = "/mnt/dpool0/notes"; }
    { device = "dpool0/other"; path = "/mnt/dpool0/other"; }
    { device = "dpool0/other"; path = "/mnt/dpool0/other"; }
    { device = "dpool0/personal"; path = "/mnt/dpool0/personal"; }
    { device = "dpool0/personal/archives"; path = "/mnt/dpool0/personal/archives"; }
    { device = "dpool0/personal/documents"; path = "/mnt/dpool0/personal/documents"; }
    { device = "dpool0/personal/finances"; path = "/mnt/dpool0/personal/finances"; }
    { device = "dpool0/personal/other"; path = "/mnt/dpool0/personal/other"; }
    { device = "dpool0/personal/projects"; path = "/mnt/dpool0/personal/projects"; }
    { device = "dpool0/resources"; path = "/mnt/dpool0/resources"; }
    { device = "dpool0/resources/databases"; path = "/mnt/dpool0/resources/databases"; }
    { device = "dpool0/resources/llms"; path = "/mnt/dpool0/resources/llms"; }
    { device = "dpool0/resources/other"; path = "/mnt/dpool0/resources/other"; }
    { device = "dpool0/resources/roms"; path = "/mnt/dpool0/resources/roms"; }
    { device = "dpool0/resources/wordlists"; path = "/mnt/dpool0/resources/wordlists"; }
    { device = "dpool0/resources/zim"; path = "/mnt/dpool0/resources/zim"; }
    { device = "dpool0/secrets"; path = "/mnt/dpool0/secrets"; }
  ];
}
