{ config, lib, pkgs, opts, ... }: {

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/qbitmanage 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    qbitmanage = {
      autoStart = true;
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      image = "ghcr.io/stuffanthings/qbit_manage:latest";
      volumes = [
        "${opts.paths.app_datafiles}/qbitmanage:/config:rw"
        "${opts.paths.app_datafiles}/qbittorrent:/qbittorrent:ro"
        "${opts.paths.torrent_watch}:/data/torrents:rw"
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
        QBT_REM_ORPHANED = "false";
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
