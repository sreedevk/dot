{ pkgs, config, opts, ... }:
{
  home.packages = with pkgs; [
    radicle-node
    radicle-httpd
  ];
}
