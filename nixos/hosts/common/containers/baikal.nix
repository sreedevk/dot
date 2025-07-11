{ pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ baikal ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/baikal 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "baikal" = {
      autoStart = false;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "ckulka/baikal:nginx";
      ports = [
        "${opts.ports.baikal}:80"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.baikal.http.parent_name" = "${opts.hostname}";
        "kuma.baikal.http.name" = "Baikal";
        "kuma.baikal.http.url" = "http://${opts.lanAddress}:${opts.ports.baikal}";
      };
      volumes = [
        "${opts.paths.app_datafiles}/baikal:/var/www/baikal/Specific"
        "${opts.paths.app_datafiles}/baikal:/var/www/baikal/config"
      ];
    };
  };
}
