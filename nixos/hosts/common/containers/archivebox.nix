{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ archivebox ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/archivebox 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "archivebox" = {
      autoStart = opts.autostart-non-essential-services;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "archivebox/archivebox:latest";
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.archivebox.http.parent_name" = "${opts.hostname}";
        "kuma.archivebox.http.name" = "ArchiveBox";
        "kuma.archivebox.http.url" = "http://${opts.lanAddress}:${opts.ports.archivebox}/health";
      };
      ports = [
        "${opts.ports.archivebox}:8000"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/archivebox:/data"
      ];
    };
  };

}
