{ pkgs, ... }:
{
  imports = [
    ./core-min.nix
  ];

  home.packages = with pkgs; [
    ast-grep         # code searching
    below            # time traveling resource monitor
    bingrep          # binary grep
    broot            # interactive file tree
    bsd-finger       # user information lookup
    cyme             # modern lsusb
    dua              # file usage
    duf              # disk usage
    eyed3            # music files id3 tag modifier
    flac             # flac encoding and decoding
    gperf            # perfect hash function generator
    grex             # regex generator
    hex              # hexdump in rust
    httpie           # command line http client
    id3v2            # music files id3v2 tag modifier
    imagemagick      # bitmap image manipulation
    iotop            # io monitoring
    jaq              # better jq
    lua              # lua lang
    luau             # luau lang
    mediainfo        # technical and tag information for audio/video files
    mosh             # mobile shell (ssh over udp)
    ncdu             # du with curses interface
    netcat-gnu       # rw data across net conns
    nettools         # linux network subsystem control
    nix-prefetch-git # git fetch nix info
    ouch             # unified fs compression util
    oxker            # docker tui
    p7zip            # p7zip compression
    pass             # passwords store
    pigz             # gzip compression
    procs            # ps in rust
    progress         # coreutils progress util
    pwgen            # password generator
    ripgrep-all      # ripgrep for more formats
    sshfs            # fuse fs over ssh
    tailspin         # fancy tail
    traceroute       # ip packet route tracker
    tree             # fs tree generator
    viddy            # modern watch
    xh               # friendly http
    xxd              # hex viewer
    yq               # yaml jq
  ];
}
