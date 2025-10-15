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
      enable = true;
      source = (pkgs.formats.yaml { }).generate "config.yaml" {
        directory = opts.paths.music;
        library = "/home/${username}/.config/beets/musiclibrary.db";
        plugins = "fetchart lastgenre";
        import = {
          move = "yes";
        };
      };
    };
  };
}
