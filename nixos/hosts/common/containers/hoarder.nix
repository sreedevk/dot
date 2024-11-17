{ config, lib, pkgs, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    chrome = {
      autoStart = true;
      image = "gcr.io/zenika-hub/alpine-chrome:123";
      ports = [ "${opts.ports.chrome}:${opts.ports.chrome}" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      cmd = [
        "--no-sandbox"
        "--disable-gpu"
        "--disable-dev-shm-usage"
        "--remote-debugging-address=0.0.0.0"
        "--remote-debugging-port=${opts.ports.chrome}"
        "--hide-scrollbars"
      ];
    };

    meilisearch = {
      autoStart = true;
      image = "getmeili/meilisearch:v1.11.1";
      ports = [ "${opts.ports.meilisearch_app}:7700" ];
      volumes = [ "${opts.paths.app_datafiles}/meilisearch:/meili_data" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environmentFiles = [ config.age.secrets.hoarder_env.path ];
      environment = {
        MEILI_NO_ANALYTICS = "true";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };

    hoarder = {
      autoStart = true;
      dependsOn = [ "meilisearch" "chrome" ];
      image = "ghcr.io/hoarder-app/hoarder:release";
      ports = [ "${opts.ports.hoarder_app}:3000" ];
      environmentFiles = [ config.age.secrets.hoarder_env.path ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.app_datafiles}/hoarder:/data" ];
      environment = {
        BROWSER_WEB_URL = "http://${opts.hostname}:${opts.ports.chrome}";
        NEXTAUTH_URL = "https://hoarder.nullptr.sh";
        DATA_DIR = "/data";
        MEILI_ADDR = "http://${opts.hostname}:${opts.ports.meilisearch_app}";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
