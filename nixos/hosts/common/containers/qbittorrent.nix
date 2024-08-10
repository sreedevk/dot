{ config, lib, pkgs, secrets, opts, ... }:
let
  vuetorrentSrc = builtins.fetchGit {
    name = "vuetorrent";
    url = "https://github.com/VueTorrent/VueTorrent";
    rev = "7aae128a7a439723c2e728cc5005510f1f5c72ce";
    ref = "latest-release";
    shallow = true;
  };
in
{

  environment.etc = {
    "vuetorrent" = {
      enable = true;
      source = vuetorrentSrc;
    };
  };

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      qbittorrent-p2p
      qbittorrent-web
    ]);

  networking.firewall.allowedUDPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      qbittorrent-p2p
    ]);

  virtualisation.oci-containers.containers = {
    # qBittorrent P2P Torrent Client
    "qbittorrent-nox" = {
      autoStart = true;
      image = "qbittorrentofficial/qbittorrent-nox:latest";
      ports = [
        "${opts.ports.qbittorrent-p2p}:6881/tcp"
        "${opts.ports.qbittorrent-p2p}:6881/udp"
        "${opts.ports.qbittorrent-web}:8001/tcp"
      ];
      environment = {
        QBT_EULA = "accept";
        QBT_VERSION = "latest";
        QBT_WEBUI_PORT = "${opts.ports.qbittorrent-web}";
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.application_data}/qbittorrent/config/:/config"
        "${opts.paths.downloads}:/downloads"
        "${opts.paths.torrent_watch}:/torrents"
        "${opts.paths.qbt_images}:/images"
        "${opts.paths.videos}:/videos"
        "${opts.paths.books}:/books"
        "${opts.paths.magazines}:/magazines"
        "/etc/vuetorrent:/vuetorrent:ro"
      ];
      extraOptions = [
        "--network=host"
        "--no-healthcheck"
        "--memory=8g"
        "--memory-swap=16g"
        "--cpus=4"
        "--read-only"
        "--stop-timeout=1800"
        "--tmpfs=/tmp"
      ];
    };
  };
}
