{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jackett ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/jackett 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads} 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "jackett" = {
      autoStart = opts.autostart-non-essential-services;
      image = "linuxserver/jackett:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [ "flareSolverr" ];
      environment = {
        AUTO_UPDATE = "true";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.jackett.http.parent_name" = "${opts.hostname}";
        "kuma.jackett.http.name" = "Jackett";
        "kuma.jackett.http.url" = "http://${opts.lanAddress}:${opts.ports.jackett}/health";
      };
      volumes = [
        "${opts.paths.app_datafiles}/jackett:/config"
        "${opts.paths.downloads}:/downloads"
      ];
      ports = [ "${opts.ports.jackett}:9117" ];
    };
  };
}
