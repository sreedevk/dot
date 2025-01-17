{ lib, config, pkgs, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  programs.wezterm = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.wezterm "wezterm";
  };
}
