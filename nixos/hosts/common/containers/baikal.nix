{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ baikal ]);
  virtualisation.oci-containers.containers = {
    "baikal" = {
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
      image = "ckulka/baikal:nginx";
      ports = [
        "${opts.ports.baikal}:80"
      ];
      labels = {
        "kuma.baikal.http.name" = "Baikal";
        "kuma.baikal.http.url" = "http://${opts.hostname}:${opts.ports.baikal}";
      };
      volumes = [
        "${opts.paths.application_data}/Baikal:/var/www/baikal/Specific"
        "${opts.paths.application_data}/Baikal:/var/www/baikal/config"
      ];
    };
  };
}
