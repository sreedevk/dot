{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ readarr ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.books}       0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.audiobooks}  0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}   0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    readarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/readarr:latest";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
        ];
      volumes = [
        "readarr_data:/config"
        "${opts.paths.books}:/books"
        "${opts.paths.audiobooks}:/audiobooks"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.readarr}:8787" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
