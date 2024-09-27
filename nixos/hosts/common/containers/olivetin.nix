{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ olivetin ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/olivetin 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "olivetin" = {
      autoStart = true;
      image = "jamesread/olivetin";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--cap-add=NET_RAW" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.app_datafiles}/olivetin:/config"
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
