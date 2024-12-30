{ pkgs, ... }:
{
  imports = [ ./colors.nix ./config.nix ];
  home.packages = with pkgs; [ rofi ];
}
