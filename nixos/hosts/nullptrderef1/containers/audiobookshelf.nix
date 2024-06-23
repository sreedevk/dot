{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "audiobookshelf" = {
      autoStart = true;
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "13378:80" ];
      volumes = [
        "${opts.paths.application_data}/AudioBookShelf:/config"
        "${opts.paths.audiobooks}:/audiobooks"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
