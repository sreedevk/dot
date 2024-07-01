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
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        APP_SECRET_TOKEN = secrets.huginn_app_secret;
        DOMAIN = "nullptrderef1";
        DATABASE_ADAPTER = "mysql2";
        DATABASE_ENCODING = "utf8mb4";
        HUGINN_DATABASE_NAME = secrets.huginn_database_name;
        HUGINN_DATABASE_USERNAME = secrets.huginn_database_username;
        HUGINN_DATABASE_PASSWORD = secrets.huginn_database_password;
        DATABASE_RECONNECT = "true";
        DATABASE_POOL = "20";
        DATABASE_HOST = secrets.huginn_database_host;
        DATABASE_PORT = opts.ports.huginn-db;
        DO_NOT_SEED = "false";
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
        MARIADB_ROOT_PASSWORD = secrets.huginn_database_password;
        MYSQL_DATABASE = secrets.huginn_database_name;
        MYSQL_PASSWORD = secrets.huginn_database_password;
        MYSQL_USER = secrets.huginn_database_username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

  };
}
