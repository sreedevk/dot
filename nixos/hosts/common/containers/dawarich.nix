{ pkgs, opts, config, ... }:
let
  # TODO: Dawarich: Setup Prometheus Exporter
  shared_rails_environment = {
    REDIS_URL = "redis://${opts.hostname}:${opts.ports.dawarich-redis}/0";
    RAILS_ENV = "development";
    DATABASE_HOST = opts.hostname;
    DATABASE_PORT = opts.ports.dawarich-db;
    DATABASE_NAME = "dawarich_development";
    DATABASE_USER = "dawarich_admin";
    MIN_MINUTES_SPENT_IN_CITY = "60";
    APPLICATION_HOSTS = "dawarich.nullptr.sh,localhost";
    TIME_ZONE = "America/New_York";
    DISTANCE_UNIT = "km";
    PROMETHEUS_EXPORTER_ENABLED = "false";
    PROMETHEUS_EXPORTER_HOST = "0.0.0.0";
    PROMETHEUS_EXPORTER_PORT = "9394";
    SELF_HOSTED = "true";
    BACKGROUND_PROCESSING_CONCURRENCY = "10";
    APPLICATION_PROTOCOL = "http";
  };
in
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [
    dawarich-app
    dawarich-db
    dawarich-redis
  ]);


  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/dawarich        0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dawarich/public 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dawarich/import 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dawarich/store  0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "dawarich_app" = {
      autoStart = true;
      image = "freikin/dawarich:latest";
      volumes = [
        "${opts.paths.app_datafiles}/dawarich/public:/var/app/public"
        "${opts.paths.app_datafiles}/dawarich/import:/var/app/tmp/imports/watched"
        "${opts.paths.app_datafiles}/dawarich/store:/var/app/storage"
      ];
      ports = [
        "${opts.ports.dawarich-app}:3000"
      ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--tty"
        "--interactive"
        "--health-cmd=wget -qO - http://127.0.0.1:3000/api/v1/health | grep -q \"status\"\\s*:\\s*\"ok\""
        "--health-interval=10s"
        "--health-retries=30"
        "--health-start-period=30s"
        "--health-timeout=10s"
      ];
      entrypoint = "web-entrypoint.sh";
      cmd = [ "bin/rails" "server" "-p" "3000" "-b" "::" ];
      environmentFiles = [ config.age.secrets.dawarich_env.path ];
      environment = shared_rails_environment;
      dependsOn = [ "dawarich_redis" "dawarich_db" ];
    };
    "dawarich_sidekiq" = {
      autoStart = true;
      image = "freikin/dawarich:latest";
      volumes = [
        "${opts.paths.app_datafiles}/dawarich/public:/var/app/public"
        "${opts.paths.app_datafiles}/dawarich/import:/var/app/tmp/imports/watched"
        "${opts.paths.app_datafiles}/dawarich/store:/var/app/storage"
      ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--tty"
        "--interactive"
        "--health-cmd=bundle exec sidekiqmon processes | grep \${HOSTNAME}"
        "--health-interval=10s"
        "--health-retries=30"
        "--health-start-period=30s"
        "--health-timeout=10s"
      ];
      entrypoint = "sidekiq-entrypoint.sh";
      environmentFiles = [ config.age.secrets.dawarich_env.path ];
      environment = shared_rails_environment;
      cmd = [ "sidekiq" ];
      dependsOn = [ "dawarich_redis" "dawarich_db" "dawarich_app" ];
    };
    "dawarich_redis" = {
      autoStart = false;
      image = "redis:7.0-alpine";
      cmd = [ "redis-server" ];
      volumes = [ "dawarich_redis:/data" ];
      environmentFiles = [ config.age.secrets.dawarich_env.path ];
      ports = [ "${opts.ports.dawarich-redis}:6379" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--health-cmd=redis-cli --raw incr ping"
        "--health-interval=10s"
        "--health-retries=5"
        "--health-start-period=30s"
        "--health-timeout=10s"
      ];
    };
    "dawarich_db" = {
      autoStart = false;
      image = "postgis/postgis:17-3.5-alpine";
      volumes = [
        "dawarich_db_data:/var/lib/postgresql/data"
        "dawarich_db_shared:/var/shared"
      ];
      environmentFiles = [ config.age.secrets.dawarich_env.path ];
      ports = [ "${opts.ports.dawarich-db}:5432" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--shm-size=1G"
        "--health-cmd=pg_isready -U ${shared_rails_environment.DATABASE_USER} -d ${shared_rails_environment.DATABASE_NAME}"
        "--health-timeout=10s"
        "--health-retries=5"
        "--health-start-period=30s"
        "--health-timeout=10s"
      ];
    };
  };
}
