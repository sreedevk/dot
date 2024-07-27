{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "audiobookshelf" = {
      autoStart = true;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      ports = [
        "${opts.ports.audiobookshelf}:80"
      ];
      volumes = [
        "${opts.paths.application_data}/AudioBookShelf:/config"
        "${opts.paths.audiobooks}:/audiobooks"
      ];
    };
  };
}
