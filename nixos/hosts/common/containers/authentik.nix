{ pkgs, config, opts, ... }:
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
      image = "postgres:16-alpine";
      ports = [ "${opts.ports.authentik-db}:5432" ];
      volumes = [ "authentik_postgres:/var/lib/postgresql/data" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environmentFiles = [ config.age.secrets.authentik_env.path ];
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "authentik-redis" = {
      autoStart = true;
      image = "redis:alpine";
      ports = [ "${opts.ports.authentik-redis}:6379" ];
      cmd = [ "--save" "60" "1" "--loglevel" "warning" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "authentik_redis:/data" ];
      environmentFiles = [ config.age.secrets.authentik_env.path ];
      environment = {
        AUTHENTIK_ERROR_REPORTING__ENABLED = "true";
        PGID = opts.adminGID;
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
        "authentik_media:/media"
        "authentik_templates:/templates"
      ];

      ports = [
        "${opts.ports.authentik-app-https}:9443"
        "${opts.ports.authentik-app-http}:9000"
      ];

      environmentFiles = [ config.age.secrets.authentik_env.path ];
      environment = {
        AUTHENTIK_REDIS__HOST = opts.hostname;
        AUTHENTIK_REDIS__PORT = opts.ports.authentik-redis;
        AUTHENTIK_POSTGRESQL__HOST = opts.hostname;
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
        "authentik_media:/media"
        "authentik_templates:/templates"
        "authentik_certs:/certs"
      ];
      environmentFiles = [ config.age.secrets.authentik_env.path ];
      environment = {
        AUTHENTIK_REDIS__HOST = opts.hostname;
        AUTHENTIK_REDIS__PORT = opts.ports.authentik-redis;
        AUTHENTIK_POSTGRESQL__HOST = opts.hostname;
        AUTHENTIK_POSTGRESQL__PORT = opts.ports.authentik-db;
      };
    };
  };
}
