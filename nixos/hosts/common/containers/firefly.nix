{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ firefly_app firefly_db ]);

  virtualisation.oci-containers.containers = {
    "firefly-db" = {
      autoStart = true;
      image = "mariadb:latest";
      ports = [ "${opts.ports.firefly_db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "${opts.paths.application_databases}/firefly:/var/lib/mysql" ];
      environmentFiles = [ config.age.secrets.firefly_env.path ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "firefly-app" = {
      autoStart = true;
      image = "fireflyiii/core:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [ "firefly-db" ];
      ports = [ "${opts.ports.firefly_app}:8080" ];
      volumes = [
        "${opts.paths.application_data}/firefly/uploads/:/var/www/html/storage/upload"
      ];
      labels = {
        "kuma.firefly.http.name" = "Firefly";
        "kuma.firefly.http.url" = "http://${opts.lanAddress}:${opts.ports.firefly_app}/health";
      };
      environmentFiles = [ config.age.secrets.firefly_env.path ];
      environment = {
        APP_ENV = "production";
        APP_URL = "https://firefly.nullptr.sh/";
        DEFAULT_LANGUAGE = "en_US";
        DEFAULT_LOCALE = "equal";
        DB_CONNECTION = "mysql";
        TRUSTED_PROXIES = "**";
        LOG_CHANNEL = "stack";
        MYSQL_USE_SSL = "false";
        MYSQL_SSL_VERIFY_SERVER_CERT = "false";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        DB_PORT = opts.ports.firefly_db;
        TZ = opts.timeZone;
      };
    };
  };
}
