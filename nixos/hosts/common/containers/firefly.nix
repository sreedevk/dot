{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "firefly-db" = {
      autoStart = true;
      image = "mariadb:latest";
      ports = [ "${opts.ports.firefly_db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "${opts.paths.application_databases}/firefly:/var/lib/mysql" ];
      environment = {
        MYSQL_ROOT_PASSWORD = secrets.firefly_database_password;
        MYSQL_DATABASE = secrets.firefly_database_name;
        MYSQL_PASSWORD = secrets.firefly_database_password;
        MYSQL_USER = secrets.firefly_database_username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "firefly-app" = {
      autoStart = true;
      image = "fireflyiii/core:latest";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [ "firefly-db" ];
      ports = [ "${opts.ports.firefly_app}:8080" ];
      volumes = [
        "${opts.paths.application_data}/firefly/uploads/:/var/www/html/storage/upload"
      ];
      environment = {
        APP_ENV = "production";
        APP_KEY = secrets.firefly_app_secret;
        APP_URL = "${secrets.firefly_app_host}";
        DEFAULT_LANGUAGE = "en_US";
        DEFAULT_LOCALE = "equal";
        DB_CONNECTION = "mysql";
        TRUSTED_PROXIES = "**";
        LOG_CHANNEL = "stack";
        DB_DATABASE = secrets.firefly_database_name;
        DB_HOST = secrets.firefly_database_host;
        MYSQL_USE_SSL = "false";
        MYSQL_SSL_VERIFY_SERVER_CERT = "false";
        DB_PASSWORD = secrets.firefly_database_password;
        DB_PORT = opts.ports.firefly_db;
        DB_USERNAME = secrets.firefly_database_username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        SITE_OWNER = secrets.firefly_app_site_owner;
        TZ = opts.timeZone;
      };
    };
  };
}
