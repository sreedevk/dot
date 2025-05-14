{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ dockge ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/dockge 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dockge/data 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dockge/stacks 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dockge/volumes 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  # https://dockge.nullptr.sh/
  virtualisation.oci-containers.containers = {
    dockge = {
      autoStart = opts.autostart-non-essential-services;
      image = "louislam/dockge:1";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
          "--cap-add=NET_ADMIN"
        ];
      ports = [ "${opts.ports.dockge}:5001" ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.app_datafiles}/dockge/data:/app/data"
        "${opts.paths.app_datafiles}/dockge/stacks:/opt/stacks"
        "${opts.paths.app_datafiles}/dockge/volumes:/opt/volumes"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.dockge.http.parent_name" = "${opts.hostname}";
        "kuma.dockge.http.name" = "Dockge";
        "kuma.dockge.http.url" = "http://${opts.lanAddress}:${opts.ports.dockge}/";
      };
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DOCKGE_STACKS_DIR = "/opt/stacks";
        DOCKGE_ENABLE_CONSOLE=true;
      };
    };
  };
}
