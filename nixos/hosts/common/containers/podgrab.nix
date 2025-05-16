{ pkgs, opts, config, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ podgrab ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/podgrab/config 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    podgrab = {
      autoStart = opts.autostart-non-essential-services;
      image = "akhilrex/podgrab:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.podgrab}:8080"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/podgrab/config:/config"
        "${opts.paths.podcasts}:/assets"
      ];
      environmentFiles = [ config.age.secrets.podgrab_env.path ];
      environment = {
        CHECK_FREQUENCY = "240";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
