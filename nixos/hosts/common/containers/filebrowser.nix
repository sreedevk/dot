{ opts, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ filebrowser ]);
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_databases}/filebrowser 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  environment.etc = {
    "filebrowser/.filebrowser.json" = {
      enable = true;
      text = ''
        {
          "port": 80,
          "baseURL": "https://fb.nullptr.sh",
          "address": "",
          "log": "stdout",
          "database": "/database/filebrowser.db",
          "root": "/srv"
        }
      '';
    };
  };

  virtualisation.oci-containers.containers = {
    "filebrowser" = {
      autoStart = true;
      image = "filebrowser/filebrowser";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.filebrowser}:80" ];
      volumes = [
        "${opts.paths.app_databases}/filebrowser:/database"
        "${opts.paths.downloads}:/srv/downloads"
        "/etc/filebrowser/.filebrowser.json:/.filebrowser.json:ro"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.filebrowser.http.parent_name" = "${opts.hostname}";
        "kuma.filebrowser.http.name" = "Filebrowser";
        "kuma.filebrowser.http.url" = "http://${opts.lanAddress}:${opts.ports.filebrowser}";
      };
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };

}
