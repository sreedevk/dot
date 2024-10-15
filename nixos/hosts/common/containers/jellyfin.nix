{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellyfin ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellyfin ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/jellyfin/config 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/jellyfin/cache 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/jellyfin/log 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "jellyfin" = {
      autoStart = true;
      image = "jellyfin/jellyfin:latest";
      volumes = [
        "${opts.paths.app_datafiles}/jellyfin/config:/config"
        "${opts.paths.app_datafiles}/jellyfin/cache:/cache"
        "${opts.paths.app_datafiles}/jellyfin/log:/log"
        "${opts.paths.movies}:/movies:ro"
        "${opts.paths.television}:/tv:ro"
        "${opts.paths.audiobooks}:/audiobooks:ro"
        "${opts.paths.music}:/music:ro"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.jellyfin.http.parent_name" = "${opts.hostname}";
        "kuma.jellyfin.http.name" = "Jellyfin";
        "kuma.jellyfin.http.url" = "http://${opts.lanAddress}:${opts.ports.jellyfin}/health";
      };
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
          "--device=/dev/dri/renderD128:/dev/dri/renderD128"
          "--device=/dev/dri/card1:/dev/dri/card1"
        ];
      ports = [ "${opts.ports.jellyfin}:8096" ];
      environment = {
        JELLYFIN_LOG_DIR = "/log";
        TZ = opts.timeZone;
      };
    };
  };
}
