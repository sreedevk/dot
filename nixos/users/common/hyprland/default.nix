{ pkgs, config, opts, ... }:
{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./modules
  ];
}
