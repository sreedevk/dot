{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ntfy ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/ntfy/cache 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/ntfy/data 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "ntfy" = {
      autoStart = true;
      image = "binwiederhier/ntfy";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      cmd = [ "serve" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      ports = [ "${opts.ports.ntfy}:80" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.ntfy.http.parent_name" = "${opts.hostname}";
        "kuma.ntfy.http.name" = "Ntfy";
        "kuma.ntfy.http.url" = "http://${opts.lanAddress}:${opts.ports.ntfy}";
      };
      volumes = [
        "${opts.paths.app_datafiles}/ntfy/cache:/var/cache/ntfy"
        "${opts.paths.app_datafiles}/ntfy/data:/etc/ntfy"
      ];
    };
  };
}
