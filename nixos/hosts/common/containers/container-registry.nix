{ pkgs, config, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ container-registry-server container-registry-web ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ container-registry-server ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/containers/server 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/containers/web 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  # container-registry-web
  virtualisation.oci-containers.containers = {
    "container-registry-server" = {
      autoStart = true;
      image = "registry:2.7";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.container-registry-server}:5000" ];
      volumes = [ "${opts.paths.app_datafiles}/containers/server:/var/lib/registry" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.registry.http.parent_name" = "${opts.hostname}";
        "kuma.registry.http.name" = "Docker Container Registry";
        "kuma.registry.http.url" = "http://${opts.lanAddress}:${opts.ports.container-registry-server}";
      };
      environmentFiles = [ config.age.secrets.container_registry_env.path ];
      environment = {
        TZ = opts.timeZone;
        USER_GID = opts.adminGID;
        USER_UID = opts.adminUID;
      };
    };

    "container-registry-web" = {
      autoStart = true;
      dependsOn = [ "container-registry-server" ];
      image = "quiq/registry-ui:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--privileged" ];
      ports = [ "${opts.ports.container-registry-web}:8000" ];
      volumes = [
        "${opts.paths.app_datafiles}/containers/web/data:/opt/data"
        "${opts.paths.app_datafiles}/containers/web/config.yml:/opt/config.yml:ro"
        "${opts.paths.app_datafiles}/containers/web/registry_password_file:/run/secrets/registry_password_file:ro"
      ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
        REGISTRY_HOSTNAME = "xdkr.nullptr.sh";
      };
    };
  };
}
