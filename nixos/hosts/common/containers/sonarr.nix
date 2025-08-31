{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ sonarr ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.television} 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}  0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    sonarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/sonarr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [
        "sonarr_data:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.sonarr}:8989" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
