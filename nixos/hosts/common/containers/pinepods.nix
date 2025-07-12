{ pkgs, opts, config, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.podcasts}                        0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}                   0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/pinepods          0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/pinepods/backups  0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      pinepods-db
      pinepods-valkey
      pinepods-app
    ]);

  virtualisation.oci-containers.containers = {
    pinepods-db = {
      image = "postgres:latest";
      autoStart = opts.autostart-non-essential-services;
      environmentFiles = [ config.age.secrets.pinepods_env.path ];
      environment = {
        POSTGRES_DB = "pinepods_db";
        PGDATA = "/var/lib/postgresql/data/pgdata";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "pinepods_data:/var/lib/postgresql/data" ];
      ports = [ "${opts.ports.pinepods-db}:5432" ];
    };
    pinepods-valkey = {
      autoStart = opts.autostart-non-essential-services;
      image = "valkey/valkey:8-alpine";
      ports = [ "${opts.ports.pinepods-valkey}:6379" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
    pinepods-app = {
      autoStart = opts.autostart-non-essential-services;
      image = "madeofpendletonwool/pinepods:latest";
      ports = [ "${opts.ports.pinepods-app}:8040" ];
      dependsOn = [ "pinepods-valkey" "pinepods-db" ];
      volumes = [
        "${opts.paths.podcasts}:/opt/pinepods/downloads"
        "${opts.paths.app_datafiles}/pinepods/backups:/opt/pinepods/backups"
      ];
      environmentFiles = [ config.age.secrets.pinepods_env.path ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      environment = {
        SEARCH_API_URL = "https://search.pinepods.online/api/search";
        PEOPLE_API_URL = "https://people.pinepods.online";
        HOSTNAME = "https://pinepods.nullptr.sh";
        DB_TYPE = "postgresql";
        DB_HOST = opts.hostname;
        DB_PORT = opts.ports.pinepods-db;
        DB_NAME = "pinepods_db";
        VALKEY_HOST = opts.hostname;
        VALKEY_PORT = opts.ports.pinepods-valkey;
        DEBUG_MODE = "false";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}

