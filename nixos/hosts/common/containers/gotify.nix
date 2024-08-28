{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ gotify ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ gotify ]);
  virtualisation.oci-containers.containers = {
    "gotify" = {
      autoStart = true;
      image = "gotify/server";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.gotify}:80" ];
      volumes = [ "${opts.paths.application_data}/gotify:/app/data" ];
      environmentFiles = [ config.age.secrets.gotify_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
