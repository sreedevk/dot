{ pkgs, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ sabnzbd ]
  );

  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ sabnzbd ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/sabnzbd 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}/Sabnzbd 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}/Sabnzbd/completed 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}/Sabnzbd/pending 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    sabnzbd = {
      autoStart = true;
      image = "lscr.io/linuxserver/sabnzbd:latest";
      ports = [ "${opts.ports.sabnzbd}:8080" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/sabnzbd:/config"
        "${opts.paths.downloads}/Sabnzbd/completed:/downloads"
        "${opts.paths.downloads}/Sabnzbd/pending:/incomplete-downloads"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
      };
    };
  };
}
