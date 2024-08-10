{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ homebox ]);
  virtualisation.oci-containers.containers = {
    "homebox" = {
      autoStart = true;
      image = "ghcr.io/hay-kot/homebox:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.homebox}:7745" ];
      volumes = [ "${opts.paths.application_data}/homebox:/data" ];
      environment = {
        HBOX_LOG_LEVEL = "info";
        HBOX_LOG_FORMAT = "text";
        HBOX_WEB_MAX_UPLOAD_SIZE = "10";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
