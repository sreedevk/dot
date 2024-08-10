{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ freshrss-app freshrss-db rss-bridge ]);

  virtualisation.oci-containers.containers = {
    "freshrss-app" = {
      autoStart = true;
      image = "freshrss/freshrss:edge";
      dependsOn = [ "freshrss-db" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/freshrss/data/:/var/www/FreshRSS/data"
        "${opts.paths.application_data}/freshrss/extensions/:/var/www/FreshRSS/extensions"
      ];
      ports = [ "${opts.ports.freshrss-app}:80" ];
      environment = {
        ADMIN_API_PASSWORD = secrets.freshrss_app_password;
        ADMIN_EMAIL = secrets.freshrss_app_site_owner;
        ADMIN_PASSWORD = secrets.freshrss_app_password;
        FRESHRSS_ENV = "production";
        CRON_MIN = "2,32";
        BASE_URL = "https://freshrss.nullptr.sh";
        DB_BASE = secrets.freshrss_database_name;
        DB_HOST = secrets.freshrss_database_host;
        DB_PASSWORD = secrets.freshrss_database_password;
        DB_USER = secrets.freshrss_database_username;
        PGID = opts.adminGID;
        PUBLISHED_PORT = "80";
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "freshrss-db" = {
      autoStart = true;
      image = "mariadb:latest";
      ports = [ "${opts.ports.freshrss-db}:3306" ];
      cmd = [ "--max-connections=128" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "${opts.paths.application_databases}/freshrss:/var/lib/mysql" ];
      environment = {
        MYSQL_DATABASE = secrets.freshrss_database_name;
        MYSQL_PASSWORD = secrets.freshrss_database_password;
        MYSQL_ROOT_PASSWORD = secrets.freshrss_database_password;
        MYSQL_USER = secrets.freshrss_database_username;
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    "rss-bridge" = {
      autoStart = true;
      image = "rssbridge/rss-bridge:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.rss-bridge}:80" ];
      volumes = [ "${opts.paths.application_data}/rss-bridge:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
