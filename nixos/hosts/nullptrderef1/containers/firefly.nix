{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "firefly-db" = {
      autoStart = true;
      image = "mariadb:lts";
      ports = [ "${opts.ports.firefly_db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_databases}/firefly:/var/lib/mysql" ];
      environment = {
        MARIADB_ROOT_PASSWORD = secrets.firefly.database.password;
        MYSQL_DATABASE = secrets.firefly.database.name;
        MYSQL_PASSWORD = secrets.firefly.database.password;
        MYSQL_USER = secrets.firefly.database.username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "firefly-app" = {
      autoStart = true;
      image = "fireflyiii/core:latest";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "firefly-db" ];
      ports = [ "${opts.ports.firefly_app}:8080" ];
      volumes = [
        "${opts.paths.application_data}/firefly/uploads/:/var/www/html/storage/upload"
      ];
      environment = {
        APP_ENV = "production";
        APP_KEY = secrets.firefly.app.secret;
        APP_URL = "http://${secrets.firefly.app.host}";
        DB_CONNECTION = "mysql";
        DB_DATABASE = secrets.firefly.database.name;
        DB_HOST = secrets.firefly.database.host;
        DB_PASSWORD = secrets.firefly.database.password;
        DB_PORT = opts.ports.firefly_db;
        DB_USERNAME = secrets.firefly.database.username;
        MYSQL_SSL_VERIFY_SERVER_CERT = "false";
        MYSQL_USE_SSL = "false";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        SITE_OWNER = secrets.firefly.app.site_owner;
        TZ = opts.timeZone;
      };
    };
  };
}
