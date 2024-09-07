{ config, lib, pkgs, opts, ... }:
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
      environment = {
        QBT_EULA = "accept";
        QBT_VERSION = "latest";
        QBT_WEBUI_PORT = "${opts.ports.qbittorrent-web}";
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.qbt.http.parent_name" = "${opts.hostname}";
        "kuma.qbt.http.name" = "qBittorrent";
        "kuma.qbt.http.url" = "http://${opts.lanAddress}:${opts.ports.qbittorrent-web}/api/v2/app/version";
      };
      volumes = [
        "${opts.paths.application_data}/qbittorrent:/config"
        "${opts.paths.downloads}:/downloads"
        "${opts.paths.torrent_watch}:/torrents"
        "${opts.paths.qbt_images}:/images"
        "${opts.paths.videos}:/videos"
        "${opts.paths.books}:/books"
        "${opts.paths.magazines}:/magazines"
        "/etc/vuetorrent:/vuetorrent:ro"
      ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--cpus=4"
        "--memory-swap=16g"
        "--memory=8g"
        "--network=host"
        "--no-healthcheck"
        "--read-only"
        "--stop-timeout=1800"
        "--tmpfs=/tmp"
      ];
    };
  };
}
