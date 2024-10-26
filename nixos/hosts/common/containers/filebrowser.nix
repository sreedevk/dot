{ opts, pkgs, ... }:
{

  # networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ filebrowser ]);
  # networking.firewall.extraCommands =
  #   builtins.concatStringsSep "\n"
  #     [
  #       "iptables -A INPUT  -p tcp --dport ${opts.ports.filebrowser} -j DROP"
  #       "iptables -A OUTPUT -p tcp --dport ${opts.ports.filebrowser} -j DROP"
  #     ];

  environment.etc = {
    "filebrowser/.filebrowser.json" = {
      enable = true;
      text = ''
        {
          "port": 80,
          "baseURL": "",
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
      image = "filebrowser/filebrowser:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "127.0.0.1:${opts.ports.filebrowser}:80" ];
      volumes = [
        "filebrowser_database:/database"
        "/etc/filebrowser/.filebrowser.json:/.filebrowser.json:ro"
        "/mnt/dpool0:/srv/dpool0"
        "${opts.paths.downloads}:/srv/downloads"
        "${opts.paths.app_datafiles}:/srv/appdata"
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
