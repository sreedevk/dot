{ config, ... }:
{
  imports = [
    ./uwsm.nix
  ];
  home.file = {
    ".config/hypr/hyprland.lua".source = ./config/hyprland.lua;
    ".config/hypr/nixbinds.lua".text = import ./binds.nix { inherit config; };
  };
}
