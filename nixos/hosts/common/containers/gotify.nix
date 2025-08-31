{ config
, pkgs
, opts
, ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ gotify ]
  );
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ gotify ]
  );
  virtualisation.oci-containers.containers = {
    "gotify" = {
      autoStart = true;
      image = "gotify/server:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [ "${opts.ports.gotify}:80" ];
      volumes = [ "gotify_data:/app/data" ];
      environmentFiles = [ config.age.secrets.gotify_env.path ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.gotify.http.parent_name" = "${opts.hostname}";
        "kuma.gotify.http.name" = "Gotify";
        "kuma.gotify.http.url" = "http://${opts.lanAddress}:${opts.ports.gotify}/health";
      };
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
