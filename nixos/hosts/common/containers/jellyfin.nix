{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellyfin ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellyfin ]);

  virtualisation.oci-containers.containers = {
    "jellyfin" = {
      autoStart = true;
      image = "jellyfin/jellyfin";
      volumes = [
        "${opts.paths.application_data}/Jellyfin/config:/config"
        "${opts.paths.application_data}/Jellyfin/cache/:/cache"
        "${opts.paths.application_data}/Jellyfin/log/:/log"
        "${opts.paths.movies}:/movies"
        "${opts.paths.television}:/tv"
        "${opts.paths.audiobooks}:/audiobooks"
        "${opts.paths.music}:/music"
      ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.jellyfin}:8096" ];
      environment = {
        JELLYFIN_LOG_DIR = "/log";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
