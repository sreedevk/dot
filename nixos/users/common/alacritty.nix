{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  programs.alacritty = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.alacritty "alacritty";
  };
}
