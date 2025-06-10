{ opts, ... }: {

  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads}/Metube 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  # TODO: create a script and wrap it in a timed systemd service unit to 
  #       auto import music (flac) using beet

  virtualisation.oci-containers.containers = {
    "metube" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/alexta69/metube:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.metube}:8081" ];
      volumes = [ "${opts.paths.downloads}/Metube:/downloads" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        UID = opts.adminUID;
        GID = opts.adminGID;
        DOWNLOAD_DIRS_INDEXABLE = "true";
        DOWNLOAD_MODE = "limited";
        MAX_CONCURRENT_DOWNLOADS = "3";
        YTDL_OPTIONS = builtins.toJSON {
          writesubtitles = true;
          subtitleslangs = [ "en" "-live_chat" ];
          updatetime = false;
          postprocessors = [
            { key = "Exec"; exec_cmd = "chmod 0664"; when = "after_move"; }
            { key = "FFmpegEmbedSubtitle"; already_have_subtitle = false; }
            { key = "FFmpegMetadata"; add_chapters = true; }
          ];
        };
      };
    };
  };
}
