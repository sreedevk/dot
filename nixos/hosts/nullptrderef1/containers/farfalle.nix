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
      ports = [ "${opts.ports.farfalle_api}:8000" "${opts.ports.searxng}:8080" "${opts.ports.farfalle_app}:3000" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        SEARCH_PROVIDER = "searxng";
        TAVILY_API_KEY = secrets.farfalle.tavily_api_key;
        SEARXNG_BASE_URL = "http://nullptrderef1:${opts.ports.searxng}/";
      };
    };
  };
}
