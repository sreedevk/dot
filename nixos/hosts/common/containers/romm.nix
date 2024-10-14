{ pkgs, opts, config, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.roms}/resources            0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.roms}/library              0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.roms}/assets               0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/romm/redis  0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/romm/config 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ romm-app romm-db ]);

  virtualisation.oci-containers.containers = {
    romm-app = {
      autoStart = true;
      image = "rommapp/romm:latest";
      ports = [ "${opts.ports.romm-app}:8080" ];
      volumes = [
        "${opts.paths.roms}/resources:/romm/resources"
        "${opts.paths.app_datafiles}/romm/redis:/redis-data"
        "${opts.paths.roms}/library:/romm/library"
        "${opts.paths.roms}/assets:/romm/assets"
        "${opts.paths.app_datafiles}/romm/config:/romm/config"
      ];
      environmentFiles = [ config.age.secrets.romm_env.path ];
      environment = {
        ROMM_HOST = opts.hostname;
        DB_HOST = opts.hostname;
        DB_PORT = opts.ports.romm-db;
        DISABLE_CSRF_PROTECTION = "true";
        DISABLE_DOWNLOAD_ENDPOINT_AUTH = "true";
        ENABLE_RESCAN_ON_FILESYSTEM_CHANGE = "true";
        RESCAN_ON_FILESYSTEM_CHANGE_DELAY = "10";
        ENABLE_SCHEDULED_RESCAN = "true";
        SCHEDULED_RESCAN_CRON = "0 3 * * *";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    romm-db = {
      autoStart = true;
      image = "rommapp/romm:latest";
      ports = [ "${opts.ports.romm-db}:3306" ];
    };
  };
}
