{ pkgs, opts, ... }:
let
  vuetorrentSrc = builtins.fetchGit {
    name    = "vuetorrent";
    url     = "https://github.com/VueTorrent/VueTorrent";
    rev     = "b235540fb39c1bdaac43e6f732fb3175b571b078";
    ref     = "nightly-release";
    shallow = true;
  };
in
{

  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads}                       0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/qbittorrent       0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/qbittorrent/watch 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  environment.etc = {
    "vuetorrent" = {
      enable = true;
      source = vuetorrentSrc;
    };
  };

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      qbittorrent-p2p
      qbittorrent-web
    ]
  );

  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      qbittorrent-p2p
    ]
  );

  systemd.services."podman-qbittorrent-nox" = {
    restartTriggers = [ vuetorrentSrc ];
  };

  virtualisation.oci-containers.containers = {
    "qbittorrent-nox" = {
      autoStart = opts.autostart-non-essential-services;
      image = "qbittorrentofficial/qbittorrent-nox:latest";
      environment = {
        QBT_LEGAL_NOTICE = "confirm";
        QBT_VERSION = "latest";
        QBT_WEBUI_PORT = "${opts.ports.qbittorrent-web}";
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.app_datafiles}/qbittorrent:/config"
        "${opts.paths.app_datafiles}/qbittorrent/watch:/torrents"
        "${opts.paths.books}:/books"
        "${opts.paths.downloads}:/downloads"
        "${opts.paths.magazines}:/magazines"
        "${opts.paths.other}:/other"
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
  };
}
