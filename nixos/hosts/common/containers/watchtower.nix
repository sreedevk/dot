{ pkgs, opts, config, ... }:
{
  virtualisation.oci-containers.containers = {
    "watchtower" = {
      autoStart = opts.autostart-non-essential-services;
      image = "containrrr/watchtower:latest";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.podmanSocket}:/var/run/docker.sock" ];
      environmentFiles = [ config.age.secrets.watchtower_env.path ];
      cmd = [ "--cleanup" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        WATCHTOWER_POLL_INTERVAL = "86400";
        WATCHTOWER_NOTIFICATIONS = "gotify";
        WATCHTOWER_NOTIFICATION_GOTIFY_TLS_SKIP_VERIFY = "true";
        WATCHTOWER_NOTIFICATION_GOTIFY_URL = "http://${opts.hostname}:${opts.ports.gotify}";
        WATCHTOWER_ROLLING_RESTART = "false";
        # WATCHTOWER_DISABLE_CONTAINERS = ""; disable on particular conainers with comma/space separated strings
        # WATCHTOWER_LABEL_ENABLE = "true"; label: com.centurylinklabs.watchtower.enable=true
      };
    };
  };
}
