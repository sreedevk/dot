{ opts, ... }:
{
  environment.etc = {
    "filebrowser/settings.json" = {
      enable = true;
      mode = "0777";
      text = builtins.toJSON
        {
          port = "80";
          baseURL = "";
          address = "";
          log = "stdout";
          database = "/database/filebrowser.db";
          root = "/srv";
        };
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
        "/etc/filebrowser/:/config"
        "${opts.paths.datapool_root}:/srv/dpool0"
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
