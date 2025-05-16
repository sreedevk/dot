{ config, lib, pkgs, opts, ... }: {
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/stash 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "whisparr" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/whisparr";
      dependsOn = [ "qbittorrent-nox" ];
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" ];
      volumes = [
        "whisparr_db:/data"
        "whisparr_config:/config"
        "${opts.paths.downloads}:/downloads"
        "${opts.paths.other}/nsfw/videos:/videos"
      ];
      ports = [ "${opts.ports.whisparr}:6969" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
    "stash" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/hotio/stash";
      volumes = [
        "stash_db:/databases"
        "${opts.paths.app_datafiles}/stash:/config"
        "${opts.paths.other}/nsfw/images:/images"
        "${opts.paths.other}/nsfw/videos:/videos"
      ];
      ports = [ "${opts.ports.stash}:9999" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" ];
    };
  };
}
