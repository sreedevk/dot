{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
    amfora
    glab
    dig
    aria2
    delta
    less
    babashka
    bat
    beanstalkd
    broot
    btop
    cmatrix
    csvlens
    direnv
    doctl
    duckdb
    duf
    dust
    eza
    fastfetch
    git
    git-crypt
    fd
    fzf
    gh
    glow
    gping
    grex
    hex
    hexyl
    hledger
    html-tidy
    htop
    httpie
    hyperfine
    instaloader
    ipcalc
    irssi
    jaq
    jq
    lf
    mdbook
    ncdu
    newsboat
    nixpkgs-fmt
    nmap
    nushell
    procs
    ripgrep
    ripgrep-all
    rsync
    sc-im
    starship
    tailspin
    taskwarrior-tui
    taskwarrior3
    tmuxinator
    tokei
    tty-clock
    uiua
    vim
    wget
    xh
    xxd
    yt-dlp
    zoxide
  ];
}
