{ pkgs, lib, config, ... }: 
let
  nixglmod = import ../common/nixGL.nix { inherit lib config pkgs; };
in
{

  home.packages = with pkgs; [
    keybase
    (nixglmod.nixGLWrapped pkgs.keybase-gui "keybase-gui")
  ];

  services.keybase.enable = true;
  services.kbfs.enable = true;

}
