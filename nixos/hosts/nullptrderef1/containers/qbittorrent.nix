{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
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
  };
}
