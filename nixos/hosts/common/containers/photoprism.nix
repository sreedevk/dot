{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "photoprism-app" = {
      autoStart = true;
      image = "photoprism/photoprism:latest";
      dependsOn = [ "photoprism-db" ];
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--privileged"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.application_data}/photoprism/app:/photoprism/storage"
        "${opts.paths.images}:/photoprism/originals"
      ];
      ports = [ "${opts.ports.photoprism_app}:2342" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        PHOTOPRISM_UPLOAD_NSFW = "true";
        PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism_app_password;
        PHOTOPRISM_ADMIN_USER = secrets.photoprism_app_username;
        PHOTOPRISM_AUTH_MODE = "password";
        PHOTOPRISM_SITE_URL = "http://nullptrderef1:${opts.ports.photoprism_app}/";
        PHOTOPRISM_ORIGINALS_LIMIT = "10000";
        PHOTOPRISM_HTTP_COMPRESSION = "gzip";
        PHOTOPRISM_LOG_LEVEL = "info";
        PHOTOPRISM_READONLY = "false";
        PHOTOPRISM_EXPERIMENTAL = "true";
        PHOTOPRISM_DISABLE_CHOWN = "false";
        PHOTOPRISM_DISABLE_WEBDAV = "false";
        PHOTOPRISM_DETECT_NSFW = "true";
        PHOTOPRISM_DISABLE_SETTINGS = "false";
        PHOTOPRISM_DISABLE_TENSORFLOW = "false";
        PHOTOPRISM_DISABLE_FACES = "false";
        PHOTOPRISM_DISABLE_CLASSIFICATION = "false";
        PHOTOPRISM_DISABLE_VECTORS = "false";
        PHOTOPRISM_DISABLE_RAW = "false";
        PHOTOPRISM_RAW_PRESETS = "false";
        PHOTOPRISM_SIDECAR_YAML = "true";
        PHOTOPRISM_BACKUP_ALBUMS = "true";
        PHOTOPRISM_BACKUP_DATABASE = "true";
        PHOTOPRISM_BACKUP_SCHEDULE = "daily";
        PHOTOPRISM_INDEX_SCHEDULE = "";
        PHOTOPRISM_AUTO_INDEX = "300";
        PHOTOPRISM_AUTO_IMPORT = "-1";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_SERVER = "nullptrderef1:${opts.ports.photoprism_db}";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_USER = secrets.photoprism_database_username;
        PHOTOPRISM_DATABASE_PASSWORD = secrets.photoprism_database_password;
        PHOTOPRISM_FFMPEG_ENCODER = "intel";
        PHOTOPRISM_UID = opts.adminUID;
        PHOTOPRISM_GID = opts.adminGID;
        PHOTOPRISM_UMASK = "0000";
      };
    };

    "photoprism-db" = {
      autoStart = true;
      image = "mariadb:11";
      cmd = [
        "--innodb-buffer-pool-size=2G"
        "--transaction-isolation=READ-COMMITTED"
        "--character-set-server=utf8mb4"
        "--collation-server=utf8mb4_unicode_ci"
        "--max-connections=512"
        "--innodb-rollback-on-timeout=OFF"
        "--innodb-lock-wait-timeout=120"
      ];
      volumes = [
        "${opts.paths.application_databases}/photoprism:/var/lib/mysql"
      ];

      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--privileged"
        "--no-healthcheck"
      ];

      ports = [ "${opts.ports.photoprism_db}:3306" ];
      environment = {
        MARIADB_AUTO_UPGRADE = "1";
        MARIADB_INITDB_SKIP_TZINFO = "1";
        MARIADB_DATABASE = "photoprism";
        MARIADB_USER = secrets.photoprism_database_username;
        MARIADB_PASSWORD = secrets.photoprism_database_password;
        MARIADB_ROOT_PASSWORD = secrets.photoprism_database_password;
      };
    };
  };
}
