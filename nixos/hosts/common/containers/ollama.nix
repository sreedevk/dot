{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ollama-api ollama-web ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/Ollama 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/OllamaWeb 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "ollama" = {
      autoStart = true;
      image = "ollama/ollama";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.app_datafiles}/Ollama:/root/.ollama" ];
      ports = [ "${opts.ports.ollama-api}:11434" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.ollama.http.parent_name" = "${opts.hostname}";
        "kuma.ollama.http.name" = "Ollama API";
        "kuma.ollama.http.url" = "http://${opts.lanAddress}:${opts.ports.ollama-api}";
      };
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
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--add-host=host.docker.internal:host-gateway"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/OllamaWeb:/app/backend/data"
      ];
      ports = [ "${opts.ports.ollama-web}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
