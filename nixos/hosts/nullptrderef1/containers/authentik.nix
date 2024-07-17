{ pkgs, secrets, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    "authentik-db" = {
      autoStart = true;
      image = "docker.io/library/postgres:16-alpine";
      ports = [ "${opts.ports.authentik-db}:5432" ];
      volumes = [
        "${opts.paths.application_databases}/authentik:/var/lib/postgresql/data"
      ];
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        AUTHENTIK_SECRET_KEY = secrets.authentik-secret-key;
        PGID = opts.adminGID;
        PG_PASS = secrets.authentik-db-password;
        POSTGRES_PASSWORD = secrets.authentik-db-password;
        POSTGRES_USER = "authentik";
        POSTGRS_DB = "authentik";
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "authentik-redis" = {
      autoStart = true;
      image = "docker.io/library/redis:alpine";
      volumes = "${opts.paths.application_data}/authentik/redis:/data";
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        AUTHENTIK_SECRET_KEY = secrets.authentik-secret-key;
        PGID = opts.adminGID;
        PG_PASS = secrets.authentik-db-password;
        POSTGRES_PASSWORD = secrets.authentik-db-password;
        POSTGRES_USER = "authentik";
        POSTGRS_DB = "authentik";
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "authentik-server" = {
      environment = {
        PG_PASS = secrets.authentik-db-password;
        AUTHENTIK_SECRET_KEY = secrets.authentik-secret-key;
      };
    };

    "authentik-worker" = { };


    # To start the initial setup, navigate to http://<your server's IP or hostname>:9000/if/flow/initial-setup/.
    # There you are prompted to set a password for the akadmin user (the default user).

  };
}
