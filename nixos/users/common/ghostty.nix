{ pkgs, lib, config, ghostty, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
in
{
  home.packages = [
    (nixglmod.nixGLWrapped ghostty.default "ghostty")
  ];
}
