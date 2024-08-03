{ pkgs, opts, system, ... }: {
  home.packages = with pkgs; [
    beets
  ];

  home.file = {
    ".config/beets/config.yaml" = {
      target = ".config/beets/config.yaml";
      executable = false;
      recursive = false;
      enable = true;
      text = ''
        directory: ${opts.paths.music}
        library: ${opts.paths.application_databases}/beets/musiclibrary.db
        plugins: fetchart lyrics lastgenre
        import:
          move: yes
      '';
    };
  };
}
