{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {

    "huginn-app" = {
      autoStart = true;
      dependsOn = [ "huginn-db" ];
      image = "ghcr.io/huginn/huginn";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.huginn-app}:3000" ];
      environment = {
        TZ = opts.timeZone;
        TIMEZONE = opts.timeZone;
        APP_SECRET_TOKEN = secrets.huginn.app.secret;
        DOMAIN = "nullptrderef1";
        DATABASE_ADAPTER = "mysql2";
        DATABASE_ENCODING = "utf8mb4";
        DATABASE_RECONNECT = "true";
        DATABASE_NAME = secrets.huginn.database.name;
        DATABASE_POOL = "20";
        DATABASE_USERNAME = secrets.huginn.database.username;
        DATABASE_PASSWORD = secrets.huginn.database.password;
        DATABASE_HOST = secrets.huginn.database.host;
        DATABASE_PORT = opts.ports.huginn-db;
        DO_NOT_SEED = "true";
        REMEMBER_FOR = "40.weeks";
        IMPORT_DEFAULT_SCENARIO_FOR_ALL_USERS = "false";
        USE_GRAPHVIZ_DOT = "dot";
      };
    };

    "huginn-db" = {
      autoStart = true;
      image = "mariadb:lts";
      ports = [ "${opts.ports.huginn-db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_databases}/huginn:/var/lib/mysql" ];
      environment = {
        MARIADB_ROOT_PASSWORD = secrets.huginn.database.password;
        MYSQL_DATABASE = secrets.huginn.database.name;
        MYSQL_PASSWORD = secrets.huginn.database.password;
        MYSQL_USER = secrets.huginn.database.username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

  };
}
