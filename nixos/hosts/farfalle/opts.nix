{
  hostname = "farfalle";
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
    audiobooks    = "/mnt/dpool0/media/audiobooks";
    books         = "/mnt/dpool0/media/books";
    documents     = "/mnt/dpool0/personal/documents";
    downloads     = "/opt/downloads";
    images        = "/mnt/dpool0/media/photos";
    magazines     = "/mnt/dpool0/media/magazines";
    media         = "/mnt/dpool0/media";
    movies        = "/mnt/dpool0/media/movies";
    music         = "/mnt/dpool0/media/music";
    podcasts      = "/mnt/dpool0/media/podcasts";
    podmanSocket  = "/var/run/podman/podman.sock";
    television    = "/mnt/dpool0/media/shows";
    videos        = "/mnt/dpool0/media/videos";
    zim           = "/mnt/dpool0/resources/zim";
    roms          = "/mnt/dpool0/resources/roms";
  };

  ports = { 
    adguard_dns               = "53";
    adguard_web               = "8000";
    adguard_web_https         = "8443";
    alloy                     = "3800";
    archivebox                = "8089";
    aria_rpc                  = "6800";
    aria_web                  = "6880";
    atticd                    = "8070";
    atticdb                   = "8071";
    audiobookshelf            = "13378";
    authentik-app-http        = "9989";
    authentik-app-https       = "9990";
    authentik-db              = "5434";
    authentik-redis           = "6388";
    baikal                    = "8945";
    bazarr                    = "6767";
    beets-webui               = "8337";
    bitmagnet-app             = "3333";
    bitmagnet-db              = "5432";
    bitmagnet-p2p             = "3334";
    chrome                    = "9222";
    container-registry-server = "5500";
    container-registry-web    = "5600";
    dawarich-app              = "8855";
    dawarich-db               = "5444";
    dawarich-redis            = "6350";
    dockge                    = "5001";
    firefly_app               = "10800";
    firefly_db                = "3338";
    firefly_importer          = "4086";
    flaresolverr              = "8191";
    ftp                       = "21";
    gotify                    = "8773";
    grafana                   = "2442";
    hoarder_app               = "3040";
    homer                     = "82";
    http                      = "80";
    https                     = "443";
    jackett                   = "9117";
    jellyfin                  = "8096";
    jellyseerr                = "5055";
    lidarr                    = "8686";
    navidrome                 = "4533";
    nginx-proxy-manager       = "81";
    ollama                    = "11434";
    openwebui                 = "3134";
    pinepods-app              = "8040";
    pinepods-db               = "5436";
    pinepods-valkey           = "6380";
    prowlarr                  = "9696";
    qbittorrent-p2p           = "6881";
    qbittorrent-web           = "8001";
    radarr                    = "7878";
    readarr                   = "8787";
    ssh                       = "22";
    tailscale_direct          = "39158";
    tailscale_p2p             = "41641";
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
