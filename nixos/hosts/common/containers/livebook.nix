{ config
, pkgs
, opts
, ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      livebook_api
      livebook_http
    ]
  );
  virtualisation.oci-containers.containers = {
    "livebook" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/livebook-dev/livebook:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.livebook_http}:8080"
        "${opts.ports.livebook_api}:8081"
      ];
      volumes = [ "livebook_data:/data" ];
      environmentFiles = [ config.age.secrets.livebook_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
