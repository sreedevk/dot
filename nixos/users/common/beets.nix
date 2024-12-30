{ opts, username, nixpkgs-stable, ... }: {
  home.packages = with nixpkgs-stable; [
    beets
  ];

  systemd.user.tmpfiles.rules = [
    "d /home/${username}/.config/beets 0755 ${opts.adminUID} ${opts.adminGID} -"
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
        plugins: fetchart lyrics lastgenre
        import:
          move: yes
      '';
    };
  };
}
