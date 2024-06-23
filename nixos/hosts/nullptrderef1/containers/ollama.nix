{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "ollama" = {
      autoStart = true;
      image = "ollama/ollama";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/Ollama:/root/.ollama" ];
      ports = [ "${opts.apps.ollama-api.app_port}:11434" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "ollama-web" = {
      autoStart = true;
      image = "ghcr.io/open-webui/open-webui:main";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--add-host=host.docker.internal:host-gateway"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.application_data}/OllamaWeb:/app/backend/data"
      ];
      ports = [ "${opts.apps.ollama-web.app_port}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
