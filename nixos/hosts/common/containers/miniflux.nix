{ pkgs, opts, config, ... }:
{

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ miniflux-db miniflux-app ]);

  virtualisation.oci-containers.containers = {
    "miniflux-app" = {
      autoStart = opts.autostart-non-essential-services;
      ports = [ "${opts.ports.miniflux-app}:8080" ];
      image = "miniflux/miniflux:latest";
      dependsOn = [ "miniflux-db" "rss-bridge" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.miniflux.http.parent_name" = "${opts.hostname}";
        "kuma.miniflux.http.name" = "MiniFlux";
        "kuma.miniflux.http.url" = "http://${opts.lanAddress}:${opts.ports.miniflux-app}";
      };
      environmentFiles = [ config.age.secrets.miniflux_env.path ];
      environment = {
        BASE_URL = "https://miniflux.nullptr.sh";
        BATCH_SIZE = "250";
        CREATE_ADMIN = "1";
        FORCE_REFRESH_INTERVAL = "1440";
        POLLING_FREQUENCY = "720";
        POLLING_SCHEDULER = "entry_frequency"; # :: round_robin | entry_frequency
        RUN_MIGRATIONS = "1";
        TZ = opts.timeZone;
        WORKER_POOL_SIZE = "20";
      };
    };

    "rss-bridge" = {
      autoStart = false;
      image = "rssbridge/rss-bridge:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.rss-bridge}:80" ];
      volumes = [ "rss-bridge-config:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "miniflux-db" = {
      autoStart = false;
      image = "postgres:15";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--health-cmd=/usr/bin/pg_isready -U miniflux"
        "--health-interval=10s"
        "--health-timeout=30s"
      ];
      environmentFiles = [ config.age.secrets.miniflux_env.path ];
      ports = [ "${opts.ports.miniflux-db}:5432" ];
      volumes = [ "miniflux_db:/var/lib/postgresql/data" ];
      environment = {
        TZ = opts.timeZone;
      };
    };
  };
}
