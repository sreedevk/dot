{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ metube ]);

  virtualisation.oci-containers.containers = {
    "metube" = {
      autoStart = true;
      image = "ghcr.io/alexta69/metube";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.metube}:8081" ];
      volumes = [ "${opts.paths.downloads}/Metube:/downloads" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        YTDL_OPTIONS = ''
          {
            "writesubtitles": true,
            "subtitleslangs": ["en","-live_chat"],
            "updatetime": false,
            "postprocessors": [
              { 
                "key":"Exec",
                "exec_cmd":"chmod 0664",
                "when":"after_move"
              },
              {
                "key": "FFmpegEmbedSubtitle",
                "already_have_subtitle": false
              },
              {
                "key": "FFmpegMetadata",
                "add_chapters": true
              }
            ]
          } 
        '';
      };
    };
  };
}
