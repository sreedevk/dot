{
  lanAddress = "192.168.1.179";
  timeZone = "America/New_York";
  adminUID = "1000";
  adminGID = "100";

  publicKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP" ];

  github.primary_user = "sreedev";
  gitlab.primary_user = "sreedev";

  paths = {
    application_data = "/mnt/dpool0/appdata";
    application_databases = "/mnt/dpool0/appdata/databases";
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

  ports = {
    adguard_dns = "53";
    adguard_web = "8000";
    archivebox = "8089";
    aria_rpc = "6800";
    aria_web = "6880";
    audiobookshelf = "13378";
    autobrr = "7474";
    baikal = "8945";
    bazarr = "6767";
    cloudbeaver = "8079";
    cockpit = "8008";
    docuseal = "6008";
    filebrowser = "6660";
    firefly_app = "6003";
    firefly_db = "3306";
    flaresolverr = "8191";
    freshrss = "8808";
    ftp = "21";
    gitea_db = "3309";
    gitea_http = "3000";
    gitea_ssh = "222";
    grafana = "2442";
    homebox = "3100";
    homer = "80";
    https = "443";
    huginn-app = "3333";
    huginn-db = "3308";
    icecast = "8099";
    jackett = "9117";
    jellyfin = "8096";
    jellyseer = "5055";
    kavita = "5000";
    lidarr = "8686";
    linkding = "9090";
    memos = "5230";
    metube = "8081";
    navidrome = "4533";
    netdata = "19999";
    ntfy = "7777";
    olivetin = "1337";
    ollama-api = "11434";
    ollama-web = "3134";
    openbooks = "8004";
    photoprism_app = "2342";
    photoprism_db = "3307";
    plex = "32400";
    portrainer_misc = "8024";
    portrainer_web = "9080";
    portrainer_web_secure = "9443";
    prometheus_app = "9001";
    prometheus_node = "9002";
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
    thelounge = "9000";
    uptime-kuma = "3001";
    vaultwarden = "9801";
    znc = "6501";
  };

  autorandr =
    {
      monitors = {
        inbuilt = "00ffffffffffff0006af9af900000000141f0104a51e13780363f5a854489d240e505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc1000001ac83080b870b0244010103e002dbc1000001a000000fe004a38335646804231343055414e0000000000024101b2001100000a410a20200068";
        office = "00ffffffffffff004c2dcb0b41334c30151c0103804728782ad691a7554ea0250c5054bfef80714f810081c081809500a9c0b3000101565e00a0a0a0295030203500c48e2100001a023a801871382d40582c4500c48e2100001e000000fd00184b1b5a19000a202020202020000000fc00533332443835300a2020202020011c02031cf14890041f1303122022230907078301000066030c00100080023a801871382d40582c4500c48e2100001e023a80d072382d40102c4580c48e2100001e011d007251d01e206e285500c48e2100001e011d00bc52d01e20b8285540c48e2100001e000000000000000000000000000000000000000000000000000000a2";
        homelab-0 = "00ffffffffffff001e6d095b783f07000a210104b53c22789e3035a7554ea3260f50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c4720556c7472612048440a2001d20203117144900403012309070783010000023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8";
        homelab-1 = "00ffffffffffff0060a30914220000001b21010380351e7828ee91a3544c99260f50542dcf00714081c081809500a9c0b300d1c00101023a801871382d40302035000f282100001e000000fc0045532d32345833410a20202020000000ff000a202020202020202020202020000000fd0030641e9020000a2020202020200195020334f4489001020304131f1fe200d5e305c000230907078301000067030c0010001048e6060501626200680000000000000000023a801871382d40302035000f282100001a8e4480a070382d40302035000f282100001a141d56a050002d30302035000f282100001a685b80a070382d40302035000f282100001a000000ee";
      };
    };

  nullptrderef1 =
    {
      mountpoints = [
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
      ];
    };
}
