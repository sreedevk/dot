{ secrets, pkgs, inputs, system, ... }: {
  home.packages = with pkgs; [
    amfora
    aria2
    babashka
    bat
    beanstalkd
    broot
    btop
    cava
    cmatrix
    csvlens
    delta
    dig
    direnv
    doctl
    duckdb
    duf
    dust
    eza
    fastfetch
    fd
    fzf
    gh
    git
    git-crypt
    gitleaks
    glab
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
    less
    lf
    mdbook
    ncdu
    newsboat
    nixpkgs-fmt
    nmap
    nushell
    pandoc
    procs
    restic
    ripgrep
    ripgrep-all
    rsync
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
