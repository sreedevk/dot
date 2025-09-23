{ lib
, ...
}:
{
  fonts.fontconfig = {
    enable = lib.mkForce true;
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
      sansSerif = [ "Iosevka Nerd Font" ];
    };
  };
}
