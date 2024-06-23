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
      ports = [ "2342:2342" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        PHOTOPRISM_UPLOAD_NSFW = "true";
        PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism.app.password;
        PHOTOPRISM_ADMIN_USER = secrets.photoprism.app.username; # TODO: UPDATES SECRETS
        PHOTOPRISM_AUTH_MODE = "password";
        PHOTOPRISM_SITE_URL = "http://nullptrderef1:2342/";
        PHOTOPRISM_ORIGINALS_LIMIT = "5000"; # file size limit for originals in MB (increase for high-res video)
        PHOTOPRISM_HTTP_COMPRESSION = "gzip"; # improves transfer speed and bandwidth utilization (none or gzip)
        PHOTOPRISM_LOG_LEVEL = "info"; # log level: trace, debug, info, warning, error, fatal, or panic
        PHOTOPRISM_READONLY = "false"; # do not modify originals directory (reduced functionality)
        PHOTOPRISM_EXPERIMENTAL = "true"; # enables experimental features
        PHOTOPRISM_DISABLE_CHOWN = "false"; # disables updating storage permissions via chmod and chown on startup
        PHOTOPRISM_DISABLE_WEBDAV = "false"; # disables built-in WebDAV server
        PHOTOPRISM_DETECT_NSFW = "true"; # automatically flags photos as private that MAY be offensive (requires TensorFlow)
        PHOTOPRISM_DISABLE_SETTINGS = "false"; # disables settings UI and API
        PHOTOPRISM_DISABLE_TENSORFLOW = "false"; # disables all features depending on TensorFlow
        PHOTOPRISM_DISABLE_FACES = "false"; # disables face detection and recognition (requires TensorFlow)
        PHOTOPRISM_DISABLE_CLASSIFICATION = "false"; # disables image classification (requires TensorFlow)
        PHOTOPRISM_DISABLE_VECTORS = "false"; # disables vector graphics support
        PHOTOPRISM_DISABLE_RAW = "false"; # disables indexing and conversion of RAW images
        PHOTOPRISM_RAW_PRESETS = "false"; # enables applying user presets when converting RAW images (reduces performance)
        PHOTOPRISM_SIDECAR_YAML = "true"; # creates YAML sidecar files to back up picture metadata
        PHOTOPRISM_BACKUP_ALBUMS = "true"; # creates YAML files to back up album metadata
        PHOTOPRISM_BACKUP_DATABASE = "true"; # creates regular backups based on the configured schedule
        PHOTOPRISM_BACKUP_SCHEDULE = "daily"; # backup SCHEDULE in cron format (e.g. "0 12 * * *" for daily at noon) or at a random time (daily, weekly)
        PHOTOPRISM_INDEX_SCHEDULE = ""; # indexing SCHEDULE in cron format (e.g. "@every 3h" for every 3 hours; "" to disable)
        PHOTOPRISM_AUTO_INDEX = "300"; # delay before automatically indexing files in SECONDS when uploading via WebDAV (-1 to disable)
        PHOTOPRISM_AUTO_IMPORT = "-1"; # delay before automatically importing files in SECONDS when uploading via WebDAV (-1 to disable)
        PHOTOPRISM_DATABASE_DRIVER = "mysql"; # MariaDB 10.5.12+ (MySQL successor) offers significantly better performance compared to SQLite
        PHOTOPRISM_DATABASE_SERVER = "${secrets.photoprism.database.host}:${secrets.photoprism.database.port}"; # MariaDB database server (hostname=port)
        PHOTOPRISM_DATABASE_NAME = secrets.photoprism.database.name; # MariaDB database schema name
        PHOTOPRISM_DATABASE_USER = secrets.photoprism.database.username; # MariaDB database user name
        PHOTOPRISM_DATABASE_PASSWORD = secrets.photoprism.database.password; # MariaDB database user password
        PHOTOPRISM_FFMPEG_ENCODER = "intel"; # H.264/AVC encoder (software, intel, nvidia, apple, raspberry, or vaapi)
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
        "${opts.paths.application_data}/photoprism/db:/var/lib/mysql"
      ];

      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--privileged"
        "--no-healthcheck"
      ];

      ports = [ "3307:3306" ];
      environment = {
        MARIADB_AUTO_UPGRADE = "1";
        MARIADB_INITDB_SKIP_TZINFO = "1";
        MARIADB_DATABASE = secrets.photoprism.database.name;
        MARIADB_USER = secrets.photoprism.database.username;
        MARIADB_PASSWORD = secrets.photoprism.database.password;
        MARIADB_ROOT_PASSWORD = secrets.photoprism.database.password;
      };
    };
  };
}
