{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam-tui
    gamescope
    steam
    retroarch
  ];
}
