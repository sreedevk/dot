{ secrets, pkgs, ... }: {
  home.packages = with pkgs; [
    cargo
  ];
}
