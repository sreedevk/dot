{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "farfalle" = {
      autoStart = true;
      image = "ghcr.io/rashadphz/farfalle:main";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--add-host=host.docker.internal:host-gateway"
        "--no-healthcheck"
      ];
      ports = [ "${opts.apps.farfalle.api_port}:8000" "${opts.apps.searxng.app_port}:8080" "${opts.apps.farfalle.app_port}:3000" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        SEARCH_PROVIDER = "searxng";
        TAVILY_API_KEY = secrets.farfalle.tavily_api_key;
        SEARXNG_BASE_URL = "http://nullptrderef1:${opts.apps.searxng.app_port}/";
      };
    };
  };
}
