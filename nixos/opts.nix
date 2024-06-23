{
  applicationUserName = "nullptrderef1";
  lanAddress = "192.168.1.179";
  timeZone = "America/New_York";
  adminUID = "1000";
  adminGID = "100";
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

  apps = {
    archivebox.app_port = "8089";
    audiobookshelf.app_port = "13378";
    autobrr.app_port = "7474";
    baikal.app_port = "8945";
    cloudbeaver.app_port = "8079";
    docuseal.app_port = "6008";
    flaresolverr.app_port = "8191";
    freshrss.app_port = "8808";
    kavita.app_port = "5000";
    linkding.app_port = "9090";
    plex.app_port = "32400";
    searxng.app_port = "9199";
    filebrowser.app_port = "6660";
    rss-bridge.app_port = "8768";
    farfalle = {
      app_port = "3199";
      api_port = "8199";
    };
    aria2 = {
      app_port = "6880";
      rpc_port = "6800";
    };
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
