{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "firefly-db" = {
      autoStart = true;
      image = "mariadb:lts";
      ports = [ "3306:3306" ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "${opts.paths.application_data}/FireFly/db:/var/lib/mysql" ];
      environment = {
        MYSQL_RANDOM_ROOT_PASSWORD = "yes";
        MYSQL_USER = "firefly";
        MYSQL_PASSWORD = secrets.firefly.db.password;
        MYSQL_DATABASE = "firefly";
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
      ports = [ "6003:8080" ];
      volumes = [
        "${opts.paths.application_data}/FireFly/uploads/:/var/www/html/storage/upload"
      ];
      environment = {
        APP_ENV = "production";
        SITE_OWNER = secrets.firefly.app.site_owner;
        APP_KEY = secrets.firefly.app.secret;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DB_CONNECTION = "mysql";
        DB_HOST = "nullptrderef1";
        DB_PORT = "3306";
        DB_DATABASE = "firefly";
        DB_USERNAME = "firefly";
        DB_PASSWORD = secrets.firefly.db.password;
        MYSQL_USE_SSL = "false";
        MYSQL_SSL_VERIFY_SERVER_CERT = "false";
        APP_URL = "http://nullptrderef1";
      };
    };
  };
}
