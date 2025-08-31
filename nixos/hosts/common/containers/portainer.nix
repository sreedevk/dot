{ pkgs, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      portainer_misc
      portainer_web
      portainer_web_secure
    ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/portainer 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    portainer = {
      autoStart = opts.autostart-non-essential-services;
      image = "portainer/portainer-ce:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.portainer_misc}:8000"
        "${opts.ports.portainer_web_secure}:9443"
        "${opts.ports.portainer_web}:9000"
      ];
      volumes = [
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
        "${opts.paths.app_datafiles}/portainer:/data"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
