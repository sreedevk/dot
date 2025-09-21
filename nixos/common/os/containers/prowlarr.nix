{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ prowlarr ]
  );

  virtualisation.oci-containers.containers = {
    prowlarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/prowlarr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [ "flareSolverr" ];
      volumes = [
        "prowlarr_data:/config"
      ];
      ports = [ "${opts.ports.prowlarr}:9696" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
