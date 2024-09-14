{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ audiobookshelf ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ audiobookshelf ]);
  virtualisation.oci-containers.containers = {
    "audiobookshelf" = {
      autoStart = true;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [
        "${opts.ports.audiobookshelf}:80"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.audiobookshelf.http.parent_name" = "${opts.hostname}";
        "kuma.audiobookshelf.http.name" = "AudioBookShelf";
        "kuma.audiobookshelf.http.url" = "http://${opts.lanAddress}:${opts.ports.audiobookshelf}/healthcheck";
      };
      volumes = [
        "${opts.paths.application_data}/AudioBookShelf:/config"
        "${opts.paths.audiobooks}:/audiobooks"
        "${opts.paths.books}:/books"
        "${opts.paths.podcasts}:/podcasts"
        "${opts.paths.magazines}:/magazines"
      ];
    };
  };
}
