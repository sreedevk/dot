{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "firefly-db" = {
      autoStart = true;
      image = "mariadb:lts";
      ports = [ "${secrets.firefly.database.port}:3306" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "${opts.paths.application_data}/firefly/db:/var/lib/mysql" ];
      environment = {
        MYSQL_RANDOM_ROOT_PASSWORD = "yes";
        MYSQL_USER = secrets.firefly.database.username;
        MYSQL_PASSWORD = secrets.firefly.database.password;
        MYSQL_DATABASE = secrets.firefly.database.name;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "firefly-app" = {
      autoStart = true;
      image = "fireflyiii/core:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "firefly-db" ];
      ports = [ "${secrets.firefly.app.port}:8080" ];
      volumes = [
        "${opts.paths.application_data}/firefly/uploads/:/var/www/html/storage/upload"
      ];
      environment = {
        APP_ENV = "production";
        SITE_OWNER = secrets.firefly.app.site_owner;
        APP_KEY = secrets.firefly.app.secret;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DB_CONNECTION = "mysql";
        DB_HOST = secrets.firefly.database.host;
        DB_PORT = secrets.firefly.database.port;
        DB_DATABASE = secrets.firefly.database.name;
        DB_USERNAME = secrets.firefly.database.username;
        DB_PASSWORD = secrets.firefly.database.password;
        MYSQL_USE_SSL = "false";
        MYSQL_SSL_VERIFY_SERVER_CERT = "false";
        APP_URL = "http://${secrets.firefly.app.host}";
      };
    };
  };
}
