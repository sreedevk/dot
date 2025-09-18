{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ jellyseerr ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/jellyseerr 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "jellyseerr" = {
      autoStart = opts.autostart-non-essential-services;
      image = "fallenbagel/jellyseerr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [ "${opts.paths.app_datafiles}/jellyseerr:/app/config" ];
      ports = [ "${opts.ports.jellyseerr}:5055" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
