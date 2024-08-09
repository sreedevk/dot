{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ flaresolverr ]);
  virtualisation.oci-containers.containers = {
    "flareSolverr" = {
      autoStart = true;
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.flaresolverr}:8191" ];
      environment = {
        LOG_LEVEL = "info";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
