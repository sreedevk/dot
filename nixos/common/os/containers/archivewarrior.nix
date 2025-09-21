{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ archivewarrior ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/archivewarrior 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    archivewarrior = {
      autoStart = opts.autostart-non-essential-services;
      image = "atdr.meo.ws/archiveteam/warrior-dockerfile:latest";
      volumes = [ "${opts.paths.app_datafiles}/archivewarrior:/data" ];
      ports = [ "${opts.ports.archivewarrior}:8001" ];

      extraOptions = [
        "--no-healthcheck"
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--cpus=2"
        "--memory=8g"
      ];

      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.archivewarrior.http.parent_name" = "${opts.hostname}";
        "kuma.archivewarrior.http.name" = "ArchiveWarrior";
        "kuma.archivewarrior.http.url" = "http://${opts.lanAddress}:${opts.ports.archivewarrior}";
      };

      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
        DOWNLOADER = "nullptrderef1";
        SELECTED_PROJECT = "auto";
        CONCURRENT_ITEMS = "4";
      };
    };
  };
}
