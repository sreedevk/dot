{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ beets ]);
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/beets 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}/Beets 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    beets = {
      autoStart = true;
      image = "lscr.io/linuxserver/beets:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.beets}:8337" ];
      volumes = [
        "${opts.paths.app_datafiles}/beets:/config"
        "${opts.paths.music}:/music"
        "${opts.paths.downloads}/Beets:/downloads"
      ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
