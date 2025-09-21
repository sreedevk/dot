{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ kapowarr ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.comics}     0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.downloads}  0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    kapowarr = {
      autoStart = opts.autostart-non-essential-services;
      image = "mrcas/kapowarr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      volumes = [
        "kapowarr_db:/app/db"
        "${opts.paths.comics}:/comics"
        "${opts.paths.downloads}:/app/temp_downloads"
      ];
      ports = [ "${opts.ports.kapowarr}:5656" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
