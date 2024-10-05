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

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/qbittorrent 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/torrent-watch 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/qbitmanage 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads} 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

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
      # labels = {
      #   "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
      #   "kuma.qbt.http.parent_name" = "${opts.hostname}";
      #   "kuma.qbt.http.name" = "qBittorrent";
      #   "kuma.qbt.http.url" = "http://${opts.lanAddress}:${opts.ports.qbittorrent-web}/api/v2/app/version";
      # };
      volumes = [
        "${opts.paths.app_datafiles}/qbittorrent:/config"
        "${opts.paths.app_datafiles}/torrent-watch:/torrents"
        "${opts.paths.books}:/books"
        "${opts.paths.downloads}:/downloads"
        "${opts.paths.magazines}:/magazines"
        "${opts.paths.qbt_images}:/images"
        "${opts.paths.videos}:/videos"
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

    qbitmanage = {
      autoStart = true;
      dependsOn = [ "qbittorrent-nox" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      image = "ghcr.io/stuffanthings/qbit_manage:latest";
      volumes = [
        "${opts.paths.app_datafiles}/qbitmanage:/config"
        "${opts.paths.app_datafiles}/torrent-watch:/data/watch"
        "${opts.paths.downloads}:/data/torrents"
      ];
      environment = {
        QBT_RUN = "false";
        QBT_SCHEDULE = "1440";
        QBT_CONFIG = "config.yml";
        QBT_LOGFILE = "activity.log";
        QBT_CROSS_SEED = "false";
        QBT_RECHECK = "false";
        QBT_CAT_UPDATE = "false";
        QBT_TAG_UPDATE = "false";
        QBT_REM_UNREGISTERED = "false";
        QBT_REM_ORPHANED = "true";
        QBT_TAG_TRACKER_ERROR = "false";
        QBT_TAG_NOHARDLINKS = "false";
        QBT_SHARE_LIMITS = "false";
        QBT_SKIP_CLEANUP = "false";
        QBT_DRY_RUN = "false";
        QBT_LOG_LEVEL = "INFO";
        QBT_DIVIDER = "=";
        QBT_WIDTH = "100";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
