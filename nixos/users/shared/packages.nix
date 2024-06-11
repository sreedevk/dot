{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
    amfora
    bat
    broot
    btop
    cmatrix
    direnv
    duckdb
    duf
    dust
    eza
    fastfetch
    fd
    fzf
    glow
    gping
    hexyl
    hledger
    htop
    httpie
    hyperfine
    instaloader
    ipcalc
    irssi
    jaq
    jq
    lf
    ncdu
    nixpkgs-fmt
    procs
    ripgrep
    ripgrep-all
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
