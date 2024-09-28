{ pkgs, opts, config, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ paperless-app paperless-db paperless-redis ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.documents}/consume 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/export 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/data 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/media 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    paperless-app = {
      autoStart = true;
      image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "paperless-db" "paperless-redis" ];
      volumes = [
        "${opts.paths.documents}/consume:/usr/src/paperless/consume"
        "${opts.paths.documents}/export:/usr/src/paperless/export"
        "${opts.paths.documents}/data:/usr/src/paperless/data"
        "${opts.paths.documents}/media:/usr/src/paperless/media"
      ];
      ports = [ "${opts.ports.paperless-app}:8000" ];
      environmentFiles = [ config.age.secrets.paperless_env.path ];
      environment = {
        PAPERLESS_REDIS = "redis://${opts.hostname}:${opts.ports.paperless-redis}";
        PAPERLESS_DBENGINE = "mariadb";
        PAPERLESS_DBHOST = "${opts.hostname}";
        PAPERLESS_DBUSER = "paperless";
        PAPERLESS_TIME_ZONE = opts.timeZone;
        PAPERLESS_OCR_LANGUAGE = "eng";
        PAPERLESS_DBPORT = opts.ports.paperless-db;
        PAPERLESS_URL = "https://docs.nullptr.sh";
        USERMAP_UID = opts.adminUID;
        USERMAP_GID = opts.adminGID;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    paperless-db = {
      autoStart = true;
      image = "docker.io/library/mariadb:11";
      volumes = [ "paperless_db:/var/lib/mysql" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.paperless-db}:3306" ];
      environmentFiles = [ config.age.secrets.paperless_env.path ];
      environment = {
        MARIADB_HOST = "${opts.hostname}";
        MARIADB_DATABASE = "paperless";
        MARIADB_USER = "paperless";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    paperless-redis = {
      autoStart = true;
      image = "docker.io/library/redis:7";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.paperless-redis}:6379" ];
      volumes = [
        "paperless_redis:/data"
      ];
    };
  };
}
