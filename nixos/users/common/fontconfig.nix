{ lib, pkgs, username, ... }: {
  fonts.fontconfig = {
    enable = lib.mkForce true;
    defaultFonts = {
      monospace = [ "Iosevka NF" ];
      serif = [ "Iosevka NF" ];
      sansSerif = [ "Iosevka NF" ];
    };
  };
}
