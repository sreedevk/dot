{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ actual-app ]);

  virtualisation.oci-containers.containers = {
    actual-app = {
      autoStart = true;
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      image = "docker.io/actualbudget/actual-server:latest";
      ports = [ "${opts.ports.actual-app}:5006" ];
      volumes = [ "${opts.paths.application_data}/actual:/data" ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
