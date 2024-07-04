{ lib, pkgs, ... }: {

  home.packages = with pkgs; [
    keybase-gui
  ];

  services.keybase.enable = true;
  services.kbfs.enable = true;

}
