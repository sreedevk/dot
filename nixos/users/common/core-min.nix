{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat       # better cat
    dig       # dns query
    direnv    # directory specific env
    dust      # file disk space usage summary
    exiftool  # rw exif information
    eza       # modern ls
    fd        # modern find
    fzf       # fuzzy finder
    jq        # json query lang
    less      # pager
    ripgrep   # faster grep
    rsync     # file sync
    starship  # shell prompt
    unrar     # rar archives utility
    wget      # cli downloader
    zoxide    # faster cd
  ];
}
