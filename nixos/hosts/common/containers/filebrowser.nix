{ config, lib, pkgs, secrets, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ filebrowser ]);

  virtualisation.oci-containers.containers = {
    "filebrowser" = {
      autoStart = true;
      image = "filebrowser/filebrowser";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
        ];
      ports = [ "${opts.ports.filebrowser}:80" ];
      volumes = [
        "/mnt/dpool0/:/srv"
        "${opts.paths.application_data}/filebrowser/settings.json:/config/settings.json"
        "${opts.paths.application_data}/filebrowser/filebrowser.db:/config/filebrowser.db"
        "${opts.paths.application_data}/filebrowser/database.db:/config/database.db"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
