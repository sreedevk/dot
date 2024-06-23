{ config, lib, pkgs, secrets, opts, ... }: {
  "jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [
      "${opts.paths.application_data}/jellyfin/config:/config"
      "${opts.paths.application_data}/jellyfin/cache/:/cache"
      "${opts.paths.application_data}/jellyfin/log/:/log"
      "${opts.paths.movies}:/movies"
      "${opts.paths.television}:/tv"
      "${opts.paths.audiobooks}:/audiobooks"
      "${opts.paths.music}:/music"
    ];
    extraOptions =
      [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
    ports = [ "8096:8096" ];
    environment = {
      JELLYFIN_LOG_DIR = "/log";
      TZ = opts.timeZone;
      PUID = opts.adminUID;
      PGID = opts.adminGID;
    };
  };
}
