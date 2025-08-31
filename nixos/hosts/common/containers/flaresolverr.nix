{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ flaresolverr ]
  );
  virtualisation.oci-containers.containers = {
    "flareSolverr" = {
      autoStart = true;
      image = "flaresolverr/flaresolverr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [ "${opts.ports.flaresolverr}:8191" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.flaresolverr.http.parent_name" = "${opts.hostname}";
        "kuma.flaresolverr.http.name" = "FlareSolverr";
        "kuma.flaresolverr.http.url" = "http://${opts.lanAddress}:${opts.ports.flaresolverr}";
      };
      environment = {
        LOG_LEVEL = "info";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
