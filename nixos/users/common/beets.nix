{ secrets, pkgs, opts, inputs, system, ... }: {
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
        directory: /mnt/dpool0/media/music
        library: /mnt/dpool0/appdata/beets/musiclibrary.db
        plugins: fetchart lyrics lastgenre
        import:
          move: yes
      '';
    };
  };
}
