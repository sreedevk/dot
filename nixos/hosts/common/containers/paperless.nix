{ pkgs, opts, secrets, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ paperless-app paperless-db paperless-redis ]);
  virtualisation.oci-containers.containers = {
    paperless-app = {
      autoStart = true;
      image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "paperless-db" "paperless-redis" ];
      volumes = [
        "${opts.paths.application_data}/paperless/consume:/usr/src/paperless/consume"
        "${opts.paths.application_data}/paperless/data:/usr/src/paperless/data"
        "${opts.paths.application_data}/paperless/export:/usr/src/paperless/export"
        "${opts.paths.application_data}/paperless/media:/usr/src/paperless/media"
      ];
      ports = [ "${opts.ports.paperless-app}:8000" ];
      environment = {
        PAPERLESS_REDIS = "redis://${opts.hostname}:${opts.ports.paperless-redis}";
        PAPERLESS_DBENGINE = "mariadb";
        PAPERLESS_DBHOST = "${opts.hostname}";
        PAPERLESS_DBUSER = "paperless";
        PAPERLESS_DBPASS = secrets.paperless-db-password;
        PAPERLESS_SECRET_KEY = secrets.paperless-db-password;
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
      volumes = [ "${opts.paths.application_databases}/paperless:/var/lib/mysql" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.paperless-db}:3306" ];
      environment = {
        MARIADB_HOST = "${opts.hostname}";
        MARIADB_DATABASE = "paperless";
        MARIADB_USER = "paperless";
        MARIADB_PASSWORD = secrets.paperless-db-password;
        MARIADB_ROOT_PASSWORD = secrets.paperless-db-password;
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
        "${opts.paths.application_data}/paperless/redis:/data"
      ];
    };
  };
}
