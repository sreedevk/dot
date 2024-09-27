{ pkgs, opts, system, ... }: {
  home.packages = with pkgs; [
    beets
  ];

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_databases}/beets/musiclibrary.db 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  home.file = {
    ".config/beets/config.yaml" = {
      target = ".config/beets/config.yaml";
      executable = false;
      recursive = false;
      enable = true;
      text = ''
        directory: ${opts.paths.music}
        library: ${opts.paths.app_databases}/beets/musiclibrary.db
        plugins: fetchart lyrics lastgenre
        import:
          move: yes
      '';
    };
  };
}
