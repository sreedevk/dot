{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellyseer ]);
  virtualisation.oci-containers.containers = {
    "jellyseer" = {
      autoStart = true;
      image = "fallenbagel/jellyseerr:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_data}/jellyseer/:/app/config" ];
      ports = [ "${opts.ports.jellyseer}:5055" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
