{ pkgs, config, ... }:
{
  home.packages = [
    (config.lib.nixGL.wrap pkgs.brave)
  ];
}
