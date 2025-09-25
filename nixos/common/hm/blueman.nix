{ pkgs, ... }:
{
  services.blueman-applet.enable = true;
  home.packages = with pkgs; [
    blueman
  ];
}
