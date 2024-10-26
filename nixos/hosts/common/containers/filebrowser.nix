{ opts, pkgs, ... }:
{
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
      ports = [ "${opts.ports.filebrowser}:80" ];
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
