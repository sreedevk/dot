{
  pkgs,
  opts,
  config,
  ...
}:
{

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}        0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/pihole 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ pihole_dns ]
  );

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      pihole_dns
      pihole_http
      pihole_https
    ]
  );

  virtualisation.oci-containers.containers = {
    pihole = {
      autoStart = true;
      image = "pihole/pihole:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--cap-add=NET_ADMIN"
      ];
      ports = [
        "${opts.ports.pihole_dns}:53/tcp"
        "${opts.ports.pihole_dns}:53/udp"
        "${opts.ports.pihole_https}:443"
        "${opts.ports.pihole_http}:80"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/pihole:/etc/pihole"
      ];
      environmentFiles = [ config.age.secrets.pihole_env.path ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
