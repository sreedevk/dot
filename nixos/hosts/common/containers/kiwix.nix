{ pkgs, config, opts, ... }:
{
  virtualisation.oci-containers.containers = {
    kiwix = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/kiwix/kiwix-serve:3.7.0";
      ports = [ "${opts.ports.kiwix}:8080" ];
      volumes = [ "${opts.paths.zim}:/data" ];
      cmd = [ "--address=0.0.0.0" "*.zim" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
