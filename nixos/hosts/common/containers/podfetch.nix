{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ podfetch ]);
  virtualisation.oci-containers.containers = {
    podfetch = {
      autoStart = true;
      image = "samuel19982/podfetch:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.podfetch}:8000"
      ];
      volumes = [
        "podfetch_db:/app/db"
        "${opts.paths.podcasts}:/app/podcasts"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        SERVER_URL = "https://podfetch.nullptr.sh";
      };
    };
  };
}
