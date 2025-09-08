{ config, opts, ... }:
{

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/meilisearch 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/hoarder 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    chrome = {
      autoStart = true;
      image = "gcr.io/zenika-hub/alpine-chrome:123";
      ports = [ "${opts.ports.chrome}:${opts.ports.chrome}" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
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
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      environmentFiles = [ config.age.secrets.hoarder_env.path ];
      environment = {
        MEILI_NO_ANALYTICS = "true";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
    # https://${opts.hostname}:${opts.ports.hoarder_app}
    hoarder = {
      autoStart = true;
      dependsOn = [
        "meilisearch"
        "chrome"
      ];
      image = "ghcr.io/hoarder-app/hoarder:release";
      ports = [ "${opts.ports.hoarder_app}:3000" ];
      environmentFiles = [ config.age.secrets.hoarder_env.path ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.hoarder.http.parent_name" = "${opts.hostname}";
        "kuma.hoarder.http.name" = "Hoarder";
        "kuma.hoarder.http.url" = "http://${opts.lanAddress}:${opts.ports.hoarder_app}/api/health";
      };
      volumes = [ "${opts.paths.app_datafiles}/hoarder:/data" ];
      environment = {
        BROWSER_WEB_URL = "http://${opts.hostname}:${opts.ports.chrome}";
        NEXTAUTH_URL = "https://kk.nullptr.sh";
        DATA_DIR = "/data";
        MEILI_ADDR = "http://${opts.hostname}:${opts.ports.meilisearch_app}";
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
