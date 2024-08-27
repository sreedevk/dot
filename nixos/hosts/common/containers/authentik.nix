{ pkgs, secrets, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [
    authentik-db
    authentik-app-http
    authentik-app-https
    authentik-redis
  ]);

  virtualisation.oci-containers.containers = {
    "authentik-db" = {
      autoStart = true;
      image = "docker.io/library/postgres:16-alpine";
      ports = [ "${opts.ports.authentik-db}:5432" ];
      volumes = [ "${opts.paths.application_databases}/Authentik/Postgres:/var/lib/postgresql/data" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        AUTHENTIK_SECRET_KEY = secrets.authentik_secret_key;
        PGID = opts.adminGID;
        PG_PASS = secrets.authentik_db_password;
        POSTGRES_PASSWORD = secrets.authentik_db_password;
        POSTGRES_USER = secrets.authentik_db_username;
        POSTGRS_DB = secrets.authentik_db_name;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "authentik-redis" = {
      autoStart = true;
      image = "docker.io/library/redis:alpine";
      ports = [ "${opts.ports.authentik-redis}:6379" ];
      cmd = [ "--save" "60" "1" "--loglevel" "warning" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_databases}/Authentik/Redis:/data" ];
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        AUTHENTIK_SECRET_KEY = secrets.authentik_secret_key;
        PGID = opts.adminGID;
        PG_PASS = secrets.authentik_db_password;
        POSTGRES_PASSWORD = secrets.authentik_db_password;
        POSTGRES_USER = secrets.authentik_db_username;
        POSTGRS_DB = secrets.authentik_db_name;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "authentik-server" = {
      autoStart = true;
      image = "ghcr.io/goauthentik/server:2024.6.4";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      cmd = [ "server" ];
      dependsOn = [ "authentik-db" "authentik-redis" ];
      volumes = [
        "${opts.paths.application_data}/Authentik/media:/media"
        "${opts.paths.application_data}/Authentik/templates:/templates"
      ];

      ports = [
        "${opts.ports.authentik-app-https}:9443"
        "${opts.ports.authentik-app-http}:9000"
      ];

      environment = {
        PG_PASS = secrets.authentik_db_password;
        AUTHENTIK_SECRET_KEY = secrets.authentik_secret_key;
        AUTHENTIK_REDIS__HOST = opts.hostname;
        AUTHENTIK_REDIS__PORT = opts.ports.authentik-redis;
        AUTHENTIK_POSTGRESQL__HOST = opts.hostname;
        AUTHENTIK_POSTGRESQL__USER = secrets.authentik_db_username;
        AUTHENTIK_POSTGRESQL__NAME = secrets.authentik_db_name;
        AUTHENTIK_POSTGRESQL__PASSWORD = secrets.authentik_db_password;
        AUTHENTIK_POSTGRESQL__PORT = opts.ports.authentik-db;
      };
    };

    "authentik-worker" = {
      autoStart = true;
      image = "ghcr.io/goauthentik/server:2024.6.4";
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "authentik-db" "authentik-redis" ];
      cmd = [ "worker" ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.application_data}/Authentik/media:/media"
        "${opts.paths.application_data}/Authentik/templates:/templates"
        "${opts.paths.application_data}/Authentik/certs:/certs"
      ];
      environment = {
        PG_PASS = secrets.authentik_db_password;
        AUTHENTIK_SECRET_KEY = secrets.authentik_secret_key;
        AUTHENTIK_REDIS__HOST = opts.hostname;
        AUTHENTIK_REDIS__PORT = opts.ports.authentik-redis;
        AUTHENTIK_POSTGRESQL__HOST = opts.hostname;
        AUTHENTIK_POSTGRESQL__USER = secrets.authentik_db_username;
        AUTHENTIK_POSTGRESQL__NAME = secrets.authentik_db_name;
        AUTHENTIK_POSTGRESQL__PASSWORD = secrets.authentik_db_password;
        AUTHENTIK_POSTGRESQL__PORT = opts.ports.authentik-db;
      };
    };


    # To start the initial setup, navigate to http://<your server's IP or hostname>:9000/if/flow/initial-setup/.
    # There you are prompted to set a password for the akadmin user (the default user).

  };
}
