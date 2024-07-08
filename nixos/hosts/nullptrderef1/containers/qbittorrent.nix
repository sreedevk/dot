{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    # qBittorrent P2P Torrent Client
    "qbittorrent-nox" = {
      autoStart = true;
      image = "qbittorrentofficial/qbittorrent-nox:latest";
      ports = [ "${opts.ports.qbittorrent-p2p}:6881/tcp" "${opts.ports.qbittorrent-p2p}:6881/udp" "${opts.ports.qbittorrent-web}:8001/tcp" ];
      environment = {
        QBT_EULA = "accept";
        QBT_VERSION = "4.6.4-1";
        QBT_WEBUI_PORT = "${opts.ports.qbittorrent-web}";
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
