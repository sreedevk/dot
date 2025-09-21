{ opts, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ nzbhydra ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/nzbhydra          0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/qbittorrent/watch 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    nzbhydra = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/nzbhydra2:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/nzbhydra:/config"
        "${opts.paths.app_datafiles}/qbittorrent/watch:/torrents"
      ];
      ports = [ "${opts.ports.nzbhydra}:5076" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        UMASK = "002";
      };
    };
  };
}
