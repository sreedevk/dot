{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ exportify ]);

  virtualisation.oci-containers.containers = {
    "exportify" = {
      autoStart = true;
      image = "dkr.xternull.duckdns.org/exportify:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.exportify}:3000" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
