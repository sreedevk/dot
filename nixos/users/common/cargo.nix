{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
    clippy
    rustc
    rustfmt
  ];
}
