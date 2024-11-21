{ pkgs, nixpkgs-stable, username, ... }: {
  home.packages = with pkgs; [
    amfora
    asciinema
    asciinema-agg
    aria2
    beanstalkd
    clang
    cmatrix
    csvlens
    hexyl
    gping
    ncdu
  ];
}
