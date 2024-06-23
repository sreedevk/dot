{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "freshRSS" = {
      autoStart = true;
      image = "freshrss/freshrss:edge";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/FreshRSS/data/:/var/www/FreshRSS/data"
        "${opts.paths.application_data}/FreshRSS/extensions/:/var/www/FreshRSS/extensions"
      ];
      ports = [ "${opts.apps.freshrss.app_port}:80" ];
      environment = {
        CRON_MIN = "2,32";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
    "rss-bridge" = {
      autoStart = true;
      image = "rssbridge/rss-bridge:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.apps.rss-bridge.app_port}:80" ];
      volumes = [ "${opts.paths.application_data}/rss-bridge:/config" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
