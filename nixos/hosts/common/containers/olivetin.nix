{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ olivetin ]);
  virtualisation.oci-containers.containers = {
    "olivetin" = {
      autoStart = opts.autostart-non-essential-services;
      image = "jamesread/olivetin:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--cap-add=NET_RAW" "--no-healthcheck" ];
      volumes = [
        "olivetin_app:/config"
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
