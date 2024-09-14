{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ glance ]);
  virtualisation.oci-containers.containers = {

    "glance" = {
      autoStart = true;
      image = "glanceapp/glance";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/Glance/glance.yml:/app/glance.yml" ];
      ports = [ "${opts.ports.glance}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

  };
}
