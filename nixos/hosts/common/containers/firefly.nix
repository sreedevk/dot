{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ firefly_app firefly_db firefly_importer ]);

  virtualisation.oci-containers.containers = {
    "firefly-app" = {
      autoStart = opts.autostart-non-essential-services;
      image = "fireflyiii/core:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [ "firefly-db" ];
      ports = [ "${opts.ports.firefly_app}:8080" ];
      volumes = [
        "firefly_uploads:/var/www/html/storage/upload"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.firefly.http.parent_name" = "${opts.hostname}";
        "kuma.firefly.http.name" = "Firefly";
        "kuma.firefly.http.url" = "http://${opts.lanAddress}:${opts.ports.firefly_app}/health";
      };
      environmentFiles = [ config.age.secrets.firefly_env.path ];
      environment = {
        APP_ENV = "production";
        APP_URL = "https://firefly.nullptr.sh";
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

    "firefly-importer" = {
      autoStart = opts.autostart-non-essential-services;
      image = "fireflyiii/data-importer:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [ "firefly-app" ];
      ports = [ "${opts.ports.firefly_importer}:8080" ];
      environment = {
        FIREFLY_III_URL = "https://firefly.external.nullptr.sh";
        VANITY_URL = "https://firefly.nullptr.sh";
        FIREFLY_III_CLIENT_ID = "13";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "firefly-db" = {
      autoStart = false;
      image = "mariadb:latest";
      ports = [ "${opts.ports.firefly_db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "firefly_db:/var/lib/mysql" ];
      environmentFiles = [ config.age.secrets.firefly_env.path ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
