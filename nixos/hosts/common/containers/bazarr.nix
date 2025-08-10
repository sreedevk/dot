{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bazarr ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.television}  0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.movies}      0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}   0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    bazarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/bazarr:latest";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
        ];
      ports = [ "${opts.ports.bazarr}:6767" ];
      volumes = [
        "bazarr_data:/config"
        "${opts.paths.television}:/tv"
        "${opts.paths.movies}:/movies"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
