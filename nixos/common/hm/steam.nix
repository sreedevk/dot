{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    steam-tui
    (config.lib.nixGL.wrapOffload pkgs.gamescope)
    (config.lib.nixGL.wrapOffload pkgs.steam)
    (config.lib.nixGL.wrapOffload pkgs.retroarch)
  ];
}
