{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ archivebox ]);
  virtualisation.oci-containers.containers = {
    "archivebox" = {
      autoStart = true;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "archivebox/archivebox";
      ports = [
        "${opts.ports.archivebox}:8000"
      ];
      volumes = [
        "${opts.paths.application_data}/archivebox:/data"
      ];
    };
  };
}
