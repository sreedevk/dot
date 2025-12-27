{ pkgs, ... }:
{
  services.blueman-applet.enable = false;
  home.packages = with pkgs; [
    blueman
  ];
}
