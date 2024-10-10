{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ dockge ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/dockge 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dockge/data 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/dockge/stacks 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    dockge = {
      autoStart = true;
      image = "louislam/dockge:1";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.dockge}:5001" ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.app_datafiles}/dockge/data:/app/data"
        "${opts.paths.app_datafiles}/dockge/stacks:/opt/stacks"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DOCKGE_STACKS_DIR = "/opt/stacks";
      };
    };
  };
}
