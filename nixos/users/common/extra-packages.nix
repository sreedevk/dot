{ pkgs, nixpkgs-stable, username, ... }: {
  home.packages = with pkgs; [
    amfora
    aria2
    asciinema
    asciinema-agg
    beanstalkd
    clang
    cmatrix
    csvlens
    gping
    hexyl
    id3v2
    ncdu
  ];
}
