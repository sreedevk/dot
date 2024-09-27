{ config, lib, pkgs, opts, ... }:
{

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ searxng-www ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/searxng 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "searxng" = {
      autoStart = true;
      image = "docker.io/searxng/searxng:latest";
      ports = [ "${opts.ports.searxng-www}:8080" ];
      volumes = [
        "${opts.paths.app_datafiles}/searxng:/etc/searxng:rw"
      ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      environment = {
        SEARXNG_BASE_URL = "https://searxng.nullptr.sh";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
