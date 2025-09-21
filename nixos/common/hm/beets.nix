{ opts
, username
, pkgs
, ...
}:
{
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
        library: /home/${username}/.config/beets/musiclibrary.db
        plugins: fetchart lastgenre
        import:
          move: yes
      '';
    };
  };
}
