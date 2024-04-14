{ configs, pkgs, ... }:
{
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    amfora
    antibody
    bat
    btop
    cava
    delta
    du-dust
    duf
    emacs
    eza
    fastfetch
    fd
    fzf
    gh
    git
    git-crypt
    glab
    glow
    gping
    hexyl
    hledger
    htop
    hyperfine
    ipcalc
    irssi
    jaq
    jq
    lf
    ncdu
    neovim
    newsboat
    procs
    ruby
    stow
    tailspin
    taskwarrior
    taskwarrior-tui
    tmux
    tokei
    xh
    xxd
    yt-dlp
    zoxide
  ];

  programs.home-manager.enable = true;

  imports = [
    ../programs
  ];
}
