{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ slskd-web slskd-incoming ]);
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/slskd 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    slskd = {
      autoStart = true;
      image = "slskd/slskd";
      ports = [
        "${opts.ports.slskd-web}:5030"
        "${opts.ports.slskd-incoming}:50300"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/slskd:/app"
      ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        SLSKD_REMOTE_CONFIGURATION = "true";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
