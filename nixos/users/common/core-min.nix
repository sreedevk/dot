{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    dig
    direnv
    dust
    exiftool
    eza
    fd
    fzf
    jq
    less
    ripgrep
    rsync
    starship
    unrar
    wget
    zoxide
  ];
}
