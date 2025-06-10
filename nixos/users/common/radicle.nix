{ pkgs, ... }:
{
  home.packages = with pkgs; [
    radicle-httpd
    radicle-node
  ];
}
