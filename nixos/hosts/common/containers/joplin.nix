{ pkgs, secrets, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    joplin-db = {
      image = "postgres:15";
      autoStart = true;
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_databases}/joplin:/var/lib/postgresql/data" ];
      ports = [ "${opts.ports.joplin-db}:5432" ];
      environment = {
        PGID = opts.adminGID;
        POSTGRES_DB = "joplin";
        POSTGRES_PASSWORD = "${secrets.joplin-db-password}";
        POSTGRES_USER = "postgres";
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    joplin-app = {
      image = "joplin/server:latest";
      autoStart = true;
      dependsOn = [ "joplin-db" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.joplin-app}:22300" ];
      environment = {
        APP_PORT = "${opts.ports.joplin-app}";
        APP_BASE_URL = "https://joplin.nullptr.sh";
        DB_CLIENT = "pg";
        POSTGRES_PASSWORD = "${secrets.joplin-db-password}";
        POSTGRES_DATABASE = "joplin";
        POSTGRES_USER = "postgres";
        POSTGRES_PORT = "${opts.ports.joplin-db}";
        POSTGRES_HOST = "nullptrderef1";
        MAILER_ENABLED = "0";
        MAILER_HOST = "";
        MAILER_PORT = "";
        MAILER_SECURE = "0";
        MAILER_AUTH_USER = "";
        MAILER_AUTH_PASSWORD = "";
        MAILER_NOREPLY_NAME = "";
        MAILER_NOREPLY_EMAIL = "";
      };
    };
  };
}
