{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ uptime-kuma ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/uptime-kuma 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    # Service Health Monitoring
    "uptime-kuma" = {
      autoStart = true;
      image = "louislam/uptime-kuma:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.app_datafiles}/uptime-kuma:/app/data" ];
      ports = [ "${opts.ports.uptime-kuma}:3001" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "autokuma" = {
      autoStart = true;
      image = "ghcr.io/bigboot/autokuma:latest";
      dependsOn = [ "uptime-kuma" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.podmanSocket}:/var/run/docker.sock" ];
      environmentFiles = [ config.age.secrets.autokuma_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        AUTOKUMA__KUMA__URL = "http://${opts.hostname}:${opts.ports.uptime-kuma}";
        AUTOKUMA__ON_DELETE = "keep";
      };
    };
  };
}
