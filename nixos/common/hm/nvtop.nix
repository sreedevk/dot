{ pkgs, config, ... }:
{
  home.packages = [
    (config.lib.nixGL.wrapOffload pkgs.nvtopPackages.full)
  ];
}
