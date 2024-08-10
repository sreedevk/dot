{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ olivetin ]);

  virtualisation.oci-containers.containers = {
    "olivetin" = {
      autoStart = true;
      image = "jamesread/olivetin";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--cap-add=NET_RAW" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/olivetin:/config"
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
      ];
      ports = [ "${opts.ports.olivetin}:1337" ];
      user = "root";
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
