{ pkgs, username, ... }: {
  home.packages = with pkgs; [
    amfora
    aria2
    asciinema
    asciinema-agg
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    babashka
    bat
    beanstalkd
    bingrep
    broot
    btop
    cava
    clang
    cmake
    cmatrix
    csvlens
    delta
    dig
    direnv
    doctl
    duckdb
    duf
    dust
    exiftool
    eza
    fastfetch
    fd
    fzf
    gh
    git
    git-crypt
    git-filter-repo
    git-sizer
    gitleaks
    glab
    glow
    gperf
    gping
    grex
    hex
    hexyl
    hexyl
    hledger
    html-tidy
    htop
    httpie
    hyperfine
    id3v2
    instaloader
    ipcalc
    irssi
    jaq
    jq
    k9s
    less
    lf
    lua
    luau
    maim
    mdbook
    mediainfo
    mosh
    nasm
    ncdu
    netcat-gnu
    nettools
    newsboat
    nixpkgs-fmt
    nmap
    nushell
    ouch
    p7zip
    pandoc
    procs
    progress
    pwgen
    python311Packages.eyed3
    restic
    ripgrep
    ripgrep-all
    rsync
    rsync
    sc-im
    sshfs
    starship
    tailspin
    taskwarrior-tui
    taskwarrior3
    tmuxinator
    tokei
    traceroute
    tree
    tty-clock
    uiua
    unrar
    vim
    wget
    xh
    xxd
    yt-dlp
    zellij
    zola
    zoxide
  ];
}
